#!/bin/bash

# Step 1: Add Spotify Repository Key To Ubuntu
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

#Step 2: Add Spotify Repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

#Step 3: Install Spotify
sudo apt-get update 
sudo apt-get install spotify-client --allow-unauthenticated -y