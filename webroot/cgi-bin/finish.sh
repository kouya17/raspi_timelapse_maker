#!/bin/bash

WEB_ROOT="/home/pi/raspi_timelapse_maker/webroot"
RECORDING_DIR="recording"
RECORDING_PATH=${WEB_ROOT}/${RECORDING_DIR}

KILL_COUNT=0
for file in `\find ${RECORDING_PATH} -maxdepth 1 -type f`; do
  PID=`cat ${file}`
  if ps -p ${PID} | grep -q record_worker; then
    kill -2 `ps ho pid --ppid=${PID}`
    KILL_COUNT=`expr ${KILL_COUNT} + 1`
  fi
done

rm -rf ${RECORDING_PATH:=/home/pi/raspi_timelapse_maker/webroot/recording}/*

echo "Content-type: text/json"
echo "Status: 200"
echo ""
echo "{\"killCount\": \"${KILL_COUNT}\"}"
