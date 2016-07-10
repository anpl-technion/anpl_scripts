#!/bin/bash

rosrun pcl_ros pointcloud_to_pcd input:=/camera/depth/points _prefix:=$HOME/ANPL/data/pointcloud/
