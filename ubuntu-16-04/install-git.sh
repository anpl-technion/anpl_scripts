#!/bin/bash

#from https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-14-04

#from https://www.howtoforge.com/install-git-on-ubuntu-13.1

#add the PPA to the local index:
sudo add-apt-repository ppa:git-core/ppa

#update the local repository index
sudo apt-get update

#and lastly install the git package.
sudo apt-get install git -y


