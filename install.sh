#!/bin/bash

if [ "`whoami`" != "root" ]; then
  echo "Please exec as root"
  exit 1
fi

# install mjpg-streamer
apt-get update -y
apt-get install -y cmake libjpeg8-dev gcc g++
git clone https://github.com/jacksonliam/mjpg-streamer.git
pushd ./mjpg-streamer/mjpg-streamer-experimental
make
make install
popd

# eneble raspi_timelapse_maker.servise
apt-get install -y chromium-browser 
cp ./systemd/raspi_timelapse_maker.service /etc/systemd/system/
systemctl enable raspi_timelapse_maker.service
systemctl start raspi_timelapse_maker.service

echo Please reboot now to complete installation
