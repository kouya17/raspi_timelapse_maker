#!/bin/bash

RECORD_PATH='/home/pi/raspi_timelapse_maker/webroot/recorded'
STREAM_DIR=`date +%Y%m%d%H%M%S`
if [ $# -lt 1 ]; then
  STREAM_DIR=$1
fi

STREAM_PATH=$RECORD_PATH/$STREAM_DIR
mkdir ${STREAM_PATH}

ffmpeg -r 150 -i http://localhost:8080/?action=stream -vcodec h264_omx -vf fps=30 -b:v 3000k $STREAM_PATH/output.mp4
