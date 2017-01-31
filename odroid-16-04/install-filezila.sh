#!/bin/bash

#from http://computernetworkingnotes.com/ubuntu-12-04-tips-and-tricks/how-to-install-filezilla-in-ubuntu.html

#add Filezilla ppa.
sudo add-apt-repository ppa:n-muench/programs-ppa

#Update repository
sudo apt-get update

#install filezilla
sudo apt-get install filezilla -y
