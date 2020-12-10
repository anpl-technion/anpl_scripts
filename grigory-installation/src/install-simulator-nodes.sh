#!/bin/bash
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
WS_SRC=$WS_PATH/src
PREFIX=/usr/ANPLprefix
SCRIPTS_DIR=~/ANPL/scripts/grigory-installation/src

cd $WS_SRC
echo WS_SRC=$WS_SRC
echo PWD=$(pwd)

# Pioneer simulator addons
while [ ! -d "$WS_SRC/pioneer_keyop" ]; do
  git clone https://bitbucket.org/ANPL/pioneer_keyop & wait $!
done

while [ ! -d "$WS_SRC/amr-ros-config" ]; do 
  git clone https://github.com/MobileRobots/amr-ros-config & wait $!
done

# Quad copter simulator addons
bash $SCRIPTS_DIR/install-rotors-simulation.sh

echo "export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$HOME/ANPL/infrastructure/mrbsp_ws/src/anpl_inf/gazebo_models" >> ~/.bashrc
