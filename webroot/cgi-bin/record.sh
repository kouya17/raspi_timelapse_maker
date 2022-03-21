#!/bin/bash

WEB_ROOT="/home/pi/raspi_timelapse_maker/webroot"
RECORDING_DIR="recording"
STREAM=`date +%Y%m%d%H%M%S`
STREAM_TXT=$STREAM.txt
STREAM_TXT_PATH=${WEB_ROOT}/${RECORDING_DIR}/${STREAM_TXT}

if [ -e ${STREAM_TXT_PATH} ]; then
  echo "Content-type: text/json"
  echo "Status: 500"
  echo ""
  echo "{\"message\": \"stream: ${STREAM} is already recording\"}"
  exit 1
fi

${WEB_ROOT}/cgi-bin/record_worker.sh ${STREAM} > /dev/null 2>&1 &
WORKER_PID=$!

echo ${WORKER_PID} > ${STREAM_TXT_PATH}

echo "Content-type: text/json"
echo "Status: 200"
echo ""
echo "{\"stream\": \"${STREAM}\", \"pid\": \"${WORKER_PID}\", \"message\": \"stream info: stream=${STREAM}, pid=${WORKER_PID}\"}"
