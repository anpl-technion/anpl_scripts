#!/bin/bash

HOST_NAME=`uname -n | tr - _`

roslaunch gtsam_infrastructure turtlebot_keyop.launch hostName:=$HOST_NAME robotName:=$1
