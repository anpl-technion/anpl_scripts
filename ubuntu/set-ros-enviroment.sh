#!/bin/bash

# rosdep update
rosdep update

# Environment setup
echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source /opt/ros/indigo/setup.bash

