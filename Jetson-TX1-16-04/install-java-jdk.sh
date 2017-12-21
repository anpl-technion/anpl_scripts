#!/bin/bash

#reomve openjdk or jre
sudo apt-get remove openjdk* -y
sudo apt-get remove openjre* -y

#from https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get

sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

sudo apt-get install oracle-java8-installer -y
