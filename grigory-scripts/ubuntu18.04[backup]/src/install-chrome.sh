#!/bin/bash

sudo apt-get update
sudo apt-get install libappindicator1 libindicator7 -y

# download file to Download folder
cd ~/Downloads
wget -O chrome.deb 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'


#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

sudo dpkg -i chrome.deb

rm -f ~/Downloads/chrome.deb
