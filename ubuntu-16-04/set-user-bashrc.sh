#!/bin/bash

PROGRAMS=/opt/ANPL
WORKING_PATH=$PROGRAMS/smartgit/

# gtsam
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/ANPLprefix/lib">>~/.bashrc

# ros kinetic
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# catkin_ws
setup-catkin_ws.sh

# smartgit
cd $WORKING_PATH/bin
./remove-menuitem.sh
./add-menuitem.sh

source ~/.bashrc
