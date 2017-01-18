#!/bin/bash

if [ -z $1 ]; then
	sudo chmod 777 /dev/ttyACM0
	roslaunch mavros px4.launch fcu_url:=/dev/ttyACM0:115200
else
	sudo chmod 777 /dev/tty$1
	roslaunch mavros px4.launch fcu_url:=/dev/tty$1:115200
fi
