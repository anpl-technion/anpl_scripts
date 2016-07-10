#!/bin/bash
##### variables #####
PORT="11311"
args=$@
args_size=$#
if [ $args_size -gt 0 ]
then
    export ROS_IP=0.0.0.0
    export ROS_MASTER_URI=http://${args[0]}:$PORT/
    export ROS_HOSTNAME=http://${args[0]}/
else
    echo "Please give Master IP as an argument"
fi

