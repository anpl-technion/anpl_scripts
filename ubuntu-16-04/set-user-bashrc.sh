#!/bin/bash

# gtsam
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/ANPLprefix/lib">>~/.bashrc

# ros kinetic
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
