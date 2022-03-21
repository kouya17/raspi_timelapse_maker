#!/bin/bash

/home/pi/raspi_timelapse_maker/webroot/cgi-bin/finish.sh
sudo shutdown now

echo "Content-type: text/plain"
echo "Status: 200"
echo ""
echo "ok"
