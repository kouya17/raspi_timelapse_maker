#!/bin/bash

cd /home/pi/raspi_timelapse_maker/mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
/home/pi/raspi_timelapse_maker/mjpg-streamer/mjpg-streamer-experimental/mjpg_streamer -o "output_http.so -w ./www" -i "input_raspicam.so" > /dev/null 2>&1 &
cd /home/pi/raspi_timelapse_maker/webroot; /usr/bin/python3 -m http.server --cgi 8000 > /dev/null 2>&1 &
/usr/bin/chromium-browser --noerrdialogs --disable-infobars --disable-background-mode --kiosk --app=http://localhost:8000
