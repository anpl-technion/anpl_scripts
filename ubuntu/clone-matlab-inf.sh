#!/bin/bash

PROJECT_DIR=~/ANPL/infrastructure

cd $PROJECT_DIR

rm -rf matlab

git clone https://bitbucket.org/ANPL/anpl_matlab_infrastructure

mv anpl_matlab_infrastructure matlab

