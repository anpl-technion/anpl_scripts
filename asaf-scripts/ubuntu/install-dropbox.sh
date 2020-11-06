#!/bin/bash

# download file to Download folder
cd ~/Downloads
wget -O dropbox.deb 'https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.2_amd64.deb'


#from https://collab.cc.gatech.edu/borg/gtsam/#quickstart

sudo dpkg -i dropbox.deb

rm -f ~/Downloads/dropbox.deb
