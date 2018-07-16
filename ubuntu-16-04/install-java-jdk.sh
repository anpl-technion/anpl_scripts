#!/bin/bash

#https://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout
JAVA_VER=`java -version 2>&1 >/dev/null | grep -E -o "java version \"[0-9._]+\"" | grep -E -o [0-9._]+`

#reomve openjdk or jre
sudo apt-get remove openjdk* -y
sudo apt-get remove openjre* -y

#from https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

sudo apt-get install oracle-java8-installer -y
