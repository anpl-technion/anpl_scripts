#!/bin/bash

PREFIX=~/prefix
PROJECT_DIR=~/ANPL/code/3rdparty

apt-get install scons
wget "http://downloads.sourceforge.net/project/jsoncpp/jsoncpp/0.5.0/jsoncpp-src-0.5.0.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fjsoncpp%2F&ts=1294425421&use_mirror=freefr"
tar -xvzf jsoncpp-src-0.5.0.tar.gz
cd jsoncpp-src-0.5.0
scons platform=linux-gcc

bash
