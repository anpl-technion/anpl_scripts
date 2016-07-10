#!/bin/bash

echo "export ROS_HOSTNAME="`uname -n`"".local"" >> ~/.bashrc
echo "export ROS_MASTER_URI='http://aevadim-04.local:11311/'" >> ~/.bashrc
