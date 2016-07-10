#!/bin/bash
echo "export PATH=\$PATH:." >> ~/.bashrc
export PATH=$PATH:.

#remove annoing msg when you tab search at ros (.gvfs)
if [ -f ~/.gvfs/ ]; then
	sudo umount ~/.gvfs/
fi

#create prefix folder for all installations 
mkdir -p ~/prefix

#create ANPL folder for all project
mkdir -p ~/ANPL

#create folder for external programs
mkdir -p ~/programs
