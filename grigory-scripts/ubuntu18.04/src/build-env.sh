#!/bin/bash

PROJECT_NAME=anpl_mrbsp
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME

cd $WS_PATH
catkin build -j7