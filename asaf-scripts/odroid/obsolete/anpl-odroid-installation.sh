#!/bin/bash

echo "Welcome to ANPL odroid enviroment installation"

echo "starting admin installation"
./setup-odroid-env.sh
./install-git.sh
./clone-scripts.sh
./setup-scripts-env-odroid.sh

echo "Quit and run in a new terminal: \"admin-installation.sh\""

