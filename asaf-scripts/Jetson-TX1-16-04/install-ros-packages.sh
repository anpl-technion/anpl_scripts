#!/bin/bash

sudo apt-get update

sudo apt-get install python-catkin-tools -y
sudo apt-get install ros-$ROS_DISTRO-ecl -y
sudo apt-get install ros-$ROS_DISTRO-rviz-visual-tools -y

# install ROS master discovery and sync
sudo apt-get install ros-$ROS_DISTRO-master-discovery-fkie -y
sudo apt-get install ros-$ROS_DISTRO-master-sync-fkie -y

#install ROS hokuyo laser
sudo apt-get install ros-$ROS_DISTRO-urg-node -y

# Install ROS xacro
sudo apt-get install ros-$ROS_DISTRO-xacro -y

# Install ROS joint-state-publisher
sudo apt-get install ros-$ROS_DISTRO-joint-state-publisher -y

# Install ROS robot-state-publisher
sudo apt-get install ros-$ROS_DISTRO-robot-state-publisher -y

# Install ROS imu-sensor-controller
sudo apt-get install ros-$ROS_DISTRO-imu-sensor-controller -y

# Install ROS controller-manager
sudo apt-get install ros-$ROS_DISTRO-controller-manager -y

# Install ROS robot-localization
sudo apt-get install ros-$ROS_DISTRO-robot-localization -y

# Install ROS rviz-imu-pluggin (for debugging)
sudo apt-get install ros-$ROS_DISTRO-rviz-imu-plugin -y

# Install ROS image-geometry
sudo apt-get install ros-$ROS_DISTRO-image-geometry -y

# Install ROS opencv3
sudo apt-get install ros-$ROS_DISTRO-opencv3 -y

# Install ROS cv-bridge
sudo apt-get install ros-$ROS_DISTRO-cv-bridge -y
