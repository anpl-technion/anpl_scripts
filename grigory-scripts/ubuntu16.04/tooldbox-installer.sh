#!/bin/bash
cd src/

while true; do
	read -p "Do you wish to install MATLAB?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-matlab-gr.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install SmartGit?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-smartgit.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install Sublime?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-sublime.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install Spotify?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-spotify.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install LyX?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-lyx.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install GVim?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-GVim.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install FileZila?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-filezila.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

while true; do
	read -p "Do you wish to install BCN3D-Cura: 3D printing slicing tool?[Y/n]" yn
	case $yn in
		[Yy]* ) bash install-BCN3D-Cura.sh & wait $!
				break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done