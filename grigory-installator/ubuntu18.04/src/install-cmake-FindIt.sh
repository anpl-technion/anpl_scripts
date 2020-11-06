#!/bin/bash

PREFIX=/usr/ANPLprefix

sudo mkdir -p $PREFIX/share/
sudo cp -R src/cmake $PREFIX/share/
sudo chown $USER $PREFIX/share