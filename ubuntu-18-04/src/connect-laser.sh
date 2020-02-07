#!/bin/bash

if [ -z $1 ]; then
	sudo chmod 777 /dev/ttyACM0
	rosrun urg_node urg_node _serial_port:=/dev/ttyACM0
else
	rosrun urg_node urg_node _serial_port:=/dev/tty$1
fi
