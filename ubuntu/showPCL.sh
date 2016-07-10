#!/bin/bash

PCL_TOPIC="$1"
if [ "$PCL_TOPIC" = "" ]; then
    rosrun pcl_ros convert_pointcloud_to_image input:=/camera/depth/points
else
    rosrun image_view image_view image:=$PCL_TOPIC
fi
