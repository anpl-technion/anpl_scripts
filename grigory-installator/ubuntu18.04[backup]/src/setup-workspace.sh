#!/bin/bash
#---Variables(For folders and dirs paths)---#
CURRENT_WD=$(pwd)
SYSTEM=ubuntu-16-04
LAB_NAME=ANPL
WORKING_FOLDER=~/$LAB_NAME/scripts
PREFIX=/usr/ANPLprefix
PROJECT_DIR=~/ANPL/infrastructure
WORKSPACE_NAME=mrbsp_ws

# initial ubuntu workspace
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git -y
sudo apt-get install dos2unix -y


# Enbling caching of BitBucket's login and password for 4 hours (14400 sec) 
git config --global credential.helper 'cache --timeout 14400'

cd
sudo mkdir -p $PREFIX
echo "export PATH=\$PATH:.:/home/$USER/$LAB_NAME/scripts/$SYSTEM" >> ~/.bashrc
echo "export PATH=\$PATH:.:$CURRENT_WD" >> ~/.bashrc
echo "export PATH=\$PATH:.:$CURRENT_WD/scr" >> ~/.bashrc
source ~/.bashrc
mkdir -p ${PROJECT_DIR}/$WORKSPACE_NAME/src


cd $CURRENT_WD/src
bash setup-ubuntu-env.sh
source ~/.bashrc
bash arrange.sh
source ~/.bashrc

cd ~/$LAB_NAME
git clone https://bitbucket.org/ANPL/anpl_scripts scripts



