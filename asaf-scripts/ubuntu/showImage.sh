#!/bin/bash

ROBOT_NAME="$1"
if [ "$ROBOT_NAME" = "" ]; then
	rosrun image_view image_view image:=/phone1/camera/image compressed
else
	rosrun image_view image_view image:=/$ROBOT_NAME/camera/image compressed
fi
