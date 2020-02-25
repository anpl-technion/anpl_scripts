#!/bin/bash

sudo apt-get install ros-$ROS_DISTRO-octomap* -y && wait $! && TMP=1
if [ $TMP -eq 1 ]; then
    echo OK
else
    echo FAIL
fi 
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
wait $!
echo "---------------------------------------------------"
    sleep 5
echo "5555555555555555555555555555555555555555555555555555"


echo is it done?

