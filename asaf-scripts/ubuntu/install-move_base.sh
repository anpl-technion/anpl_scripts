#!/bin/bash

sudo apt-get install libsdl1.2-dev libsdl-image1.2 -y
rm -rf ~/catkin_ws/src/navigation
cd ~/catkin_ws/src
git clone -b hydro-devel https://github.com/ros-planning/navigation.git
cd navigation/
rm -rf a* b* carrot_planner/ clear_costmap_recovery/ d* f* g* move_slow_and_clear/ navfn/ navigation/ r* 
cd ~/catkin_ws
catkin_make
