#!/bin/bash

#from http://www.vlfeat.org/compiling-unix.html
#from http://www.vlfeat.org/download.html

#need install gcc4.7 for compiling with matlab
install-gcc4.7.sh

#check matlab version
MATLAB_VER=`matlab -e | grep -E -o R[0-9]+[ab] |uniq`
MAKE_FLAGS=""
PREFIX=~/prefix
PROJECT_DIR=~/ANPL/code/3rdparty
INSTALL_DIR=$PROJECT_DIR/vlfeat/toolbox

#if there is no matlab install on the machine
if [ ! -z "$MATLAB_VER" ]; then
	#flags for matlab
    MAKE_FLAGS="MEX=/usr/local/MATLAB/$MATLAB_VER/bin/mex $MAKE_FLAGS"
fi

rm -rf $PROJECT_DIR/vlfeat
cd $PROJECT_DIR
git clone git://github.com/vlfeat/vlfeat.git
cd vlfeat
make $MAKE_FLAGS

sudo matlab -nodesktop -nosplash -r "addpath(genpath('$INSTALL_DIR'));run('$INSTALL_DIR/vl_setup');savepath;exit;"
