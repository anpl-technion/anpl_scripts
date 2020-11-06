#!/bin/bash

PROGRAM_PATH=~/ANPL/code/3rdparty
INSTALL_PATH=$PROGRAM_PATH/matlab_rosjava_toolbox

FROM_GIT=True

rm -rf $INSTALL_PATH
: ' old code, do not use
if [ ! "$FROM_GIT" = True ]; then
    cd ~/Downloads
    wget -O ROSIOPackage.zip https://www.mathworks.com/hardware-support/files/ROSIOPackage-R2014a_v0.1.6.2_glnxa64-Install.zip
    unzip ROSIOPackage.zip -d .
    cd ROSIOPackage-*
    chmod +x ROSIOPackage-*
    Y| ./ROSIOPackage-*
    rm ~/Download -rf ROSIOPackage*
else
    cd ~
    git clone https://bitbucket.org/ANPL/rosio.git MATLAB
fi
'

cd $PROGRAM_PATH
git clone https://bitbucket.org/ANPL/matlab_rosjava_toolbox

sudo matlab -nodesktop -nosplash -r "addpath('$INSTALL_PATH');addpath('$INSTALL_PATH/example');addpath('$INSTALL_PATH/examples');addpath('$INSTALL_PATH/matpcl');rosmatlab_SetPath;rosmatlab_AddClassPath;exit;"
