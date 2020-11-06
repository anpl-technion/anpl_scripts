#!/bin/bash

WORLD_FILE="$1"
if [ "$WORLD_FILE" = "" ]; then
	roslaunch gtsam_infrastructure turtlebot_world.launch world_file:=/opt/ros/indigo/share/turtlebot_gazebo/worlds/empty.world
else
    roslaunch gtsam_infrastructure turtlebot_world.launch world_file:=$WORLD_FILE
fi
