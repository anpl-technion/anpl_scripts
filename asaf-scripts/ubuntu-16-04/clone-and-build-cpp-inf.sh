#!/bin/bash

PROJECT_DIR=~/ANPL/infrastructure

cd $PROJECT_DIR

rm -rf cpp

git clone https://bitbucket.org/ANPL/anpl_infrastructur_cpp

mv anpl_infrastructur_cpp cpp

mkdir cpp/robots/build

cd cpp/robots/build

cmake ..
make
