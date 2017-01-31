#!/bin/bash

sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt-get update
sudo apt-get install openjdk-7-jdk -y
sudo update-alternatives --config java
sudo update-alternatives --config javac

#sudo add-apt-repository ppa:openjdk-r/ppa -y
#sudo apt-get update 
#sudo apt-get install openjdk-8-jdk -y
#sudo update-alternatives --config java
#sudo update-alternatives --config javac

java -version


