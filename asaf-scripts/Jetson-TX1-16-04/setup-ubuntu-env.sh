#!/bin/bash

./set-title.sh
LAB=ANPL

echo "export PATH=\$PATH:." >> ~/.bashrc
export PATH=$PATH:.

#remove annoing msg when you tab search at ros (.gvfs)
if [ -f ~/.gvfs/ ]; then
	sudo umount ~/.gvfs/
fi

#create folder for external programs
mkdir -p ~/$LAB/programs

mkdir -p ~/$LAB/code
mkdir -p ~/$LAB/code/3rdparty
mkdir -p ~/$LAB/data
mkdir -p ~/$LAB/infrastructure
mkdir -p ~/$LAB/papers
