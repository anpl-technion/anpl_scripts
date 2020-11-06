#!/bin/bash

WS=~ANPL/scripts/ubuntu-16-04
FILE_LOCATION=$WS/inst-ws
PREFIX=/usr/ANPLprefix

sudo mkdir -p $PREFIX/share/
sudo cp -R src/cmake $PREFIX/share/
sudo chown $USER $PREFIX/share