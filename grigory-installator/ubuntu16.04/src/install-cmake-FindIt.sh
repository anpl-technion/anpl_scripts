#!/bin/bash

PREFIX=/usr/ANPLprefix
#scripts assumes your running it from folder above "src" (of the script folder)
sudo mkdir -p $PREFIX/share/
sudo cp -R src/cmake $PREFIX/share/
sudo chown $USER $PREFIX/share
