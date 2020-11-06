#!/bin/bash

#from: http://www.omgubuntu.co.uk/2015/03/new-features-vlc-2-2-ubuntu-ppa
#sudo add-apt-repository ppa:videolan/stable-daily
#from: http://askubuntu.com/questions/565422/how-to-install-vlc-2-2-in-ubuntu-14-04
sudo add-apt-repository ppa:mc3man/trusty-media

sudo apt-get update

#from http://askubuntu.com/questions/105587/how-to-update-vlc-to-the-latest-version
sudo apt-get install vlc vlc-plugin-* -y
