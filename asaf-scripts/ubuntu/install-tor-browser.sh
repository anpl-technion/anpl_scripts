#!/bin/bash

#from http://askubuntu.com/questions/514853/tor-browser-install-ubuntu-14-04

# Add PPA
sudo add-apt-repository ppa:webupd8team/tor-browser

# Update to make apt aware of the new PPA
sudo apt-get update

# Install tor browser
sudo apt-get install tor-browser -y
