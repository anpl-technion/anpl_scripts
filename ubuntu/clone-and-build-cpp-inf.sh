#!/bin/bash

PROJECT_DIR=~/ANPL/infrastructure

cd $PROJECT_DIR

rm -rf cpp

git clone https://bitbucket.org/ANPL/anpl_infrastructur_cpp

mv anpl_infrastructur_cpp cpp

mkdir cpp/build

cd cpp/build

cmake ..
make
