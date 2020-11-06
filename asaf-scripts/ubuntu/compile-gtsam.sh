#!/bin/bash


GTSAM_VER="3.2.0"
PROJECT_DIR=~/ANPL


cd $PROJECT_DIR/gtsam-$GTSAM_VER/build-release
sudo make install -j1
