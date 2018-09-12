#!/bin/bash


PROJECT_DIR=~/ANPL/code/3rdparty
FOLDER_NAME=UnrealEngine
LINK=https://github.com/EpicGames/UnrealEngine


sudo rm -rf $PROJECT_DIR/$FOLDER_NAME

mkdir -p $PROJECT_DIR
cd $PROJECT_DIR
git clone -b release $LINK $FOLDER_NAME
cd $PROJECT_DIR/$FOLDER_NAME

./Setup.sh
./GenerateProjectFiles.sh
make

cd ..
sudo mkdir -p /usr/ANPLprefix
sudo cp -R UnrealEngine/ /usr/ANPLprefix/
