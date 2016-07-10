#!/bin/bash

HOST_NAME=`uname -n | tr - _`

if [ ! -z $1 ]; then
	roslaunch gtsam_infrastructure $1.launch hostName:=$HOST_NAME
else
	roslaunch gtsam_infrastructure robots2.launch hostName:=$HOST_NAME
fi
