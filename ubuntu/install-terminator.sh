#!/bin/bash

#from http://technicalworldforyou.blogspot.co.il/2012/11/install-terminator-terminal-emulator-in.html

#Step1: Add Terminator Repository
sudo add-apt-repository ppa:gnome-terminator

#Step2: Update sources.list
sudo apt-get update

#Step 3: Install Terminator
sudo apt-get install terminator -y
