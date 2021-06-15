#!/bin/bash
WS_NAME=mrbsp_ws
WS_PATH=~/ANPL/infrastructure/$WS_NAME
WS_SRC=$WS_PATH/src
PREFIX=/usr/ANPLprefix
SCRIPTS_DIR=~/ANPL/scripts/grigory-installation/src
MAV_DIR=mav_comm
ROTOR_DIR=rotors_simulator

cd $WS_SRC

# Pioneer simulator addons
while [ ! -d "$WS_SRC/pioneer_keyop" ]; do
  git clone https://github.com/anpl-technion/pioneer_keyop & wait $!
done

while [ ! -d "$WS_SRC/amr-ros-config" ]; do 
  git clone https://github.com/MobileRobots/amr-ros-config & wait $!
done

# Quad copter simulator addons
#bash $SCRIPTS_DIR/install-rotors-simulation.sh
sudo apt-get install autoconf -y
sudo apt-get install protobuf-compiler -y
sudo apt-get install libgoogle-glog-dev -y

rm -fr WS_SRC/$MAV_DIR
rm -fr WS_SRC/$ROTOR_DIR

while [ ! -d "$WS_SRC/$MAV_DIR" ]; do
	git clone https://github.com/ethz-asl/mav_comm.git $MAV_DIR
done
# rotors_gazebo_plugins often gets updates, which might be unstable.
# Replacing with last actually working commit to the day 18.12.2019.
# might be deleted with stable release of rotors_simulator.
cd $MAV_DIR && git checkout 5b16cb2 && cd ..

while [ ! -d "$WS_SRC/$ROTOR_DIR" ]; do
	git clone --recursive https://github.com/ethz-asl/rotors_simulator.git $ROTOR_DIR
done
cd $ROTOR_DIR && git checkout ac77a8a && cd ..

#delete rotors_hil_interface because we didn't figure out yet how to compile it.
cd $WS_SRC/$ROTOR_DIR
rm -rf rotors_hil_interface/

echo "export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$HOME/ANPL/infrastructure/mrbsp_ws/src/anpl_inf/gazebo_models" >> ~/.bashrc
