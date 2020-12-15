#!/bin/bash

# Add PPA
sudo add-apt-repository ppa:lyx-devel/release
# Update to make apt aware of the new PPA
sudo apt-get update
# Install LyX
sudo apt-get install lyx -y

