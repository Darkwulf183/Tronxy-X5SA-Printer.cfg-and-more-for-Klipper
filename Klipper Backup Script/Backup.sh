#!/bin/bash

echo "`date -u`" >> /home/pi/klipper_config/Backuplogs/log_ready.log
echo "`date -u`" >> /home/pi/klipper_config/Backuplogs/log_fail.log

# rm -rv /media/timeusb/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log 
# sleep 1s ; cp -rpv /home/pi/klipper_config/ /media/timeusb/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log

rm -rv /home/pi/shares/klipper/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log 
sleep 1s ; cp -rpv /home/pi/klipper_config/ /home/pi/shares/klipper/Backup/klipper_config 1>> /home/pi/klipper_config/Backuplogs/log_ready.log 2>> /home/pi/klipper_config/Backuplogs/log_fail.log


echo "$(tail -65 /home/pi/klipper_config/Backuplogs/log_ready.log)" > /home/pi/klipper_config/Backuplogs/log_ready.log
echo "$(tail -65 /home/pi/klipper_config/Backuplogs/log_fail.log)" > /home/pi/klipper_config/Backuplogs/log_fail.log
