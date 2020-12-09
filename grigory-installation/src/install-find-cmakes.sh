#!/bin/bash

# copy necessarily cmake files to prefix path
PREFIX=/usr/ANPLprefix

sudo mkdir -p $PREFIX/share
sudo cp -rv cmake $PREFIX/share/
