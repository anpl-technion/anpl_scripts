#!/bin/bash

MRBSP_WS=~/ANPL/code/mrbsp_ws

cd $MRBSP_WS/src
git clone https://bitbucket.org/ANPL/anpl_software_workshop
cd ..
catkin build

