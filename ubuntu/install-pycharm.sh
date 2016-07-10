#!/bin/bash

#from http://www.sysads.co.uk/2014/06/install-pycharm-3-4-ubuntu-14-04/
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -

sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu trusty-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

sudo apt-get update
sudo apt-get install pycharm -y


