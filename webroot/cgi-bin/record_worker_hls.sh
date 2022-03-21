#!/bin/bash

RECORD_PATH='/home/pi/raspi_timelapse_maker/webroot/recorded'
STREAM_DIR=`date +%Y%m%d%H%M%S`
if [ $# -lt 1 ]; then
  STREAM_DIR=$1
fi

STREAM_PATH=$RECORD_PATH/$STREAM_DIR
mkdir ${STREAM_PATH}

ffmpeg -r 150 -i http://localhost:8080/?action=stream -f hls -vcodec h264_omx -vf fps=30 -b:v 3000k -hls_time 10 -hls_list_size 0 -hls_segment_filename $STREAM_PATH/%d.ts $STREAM_PATH/playlist.m3u8
