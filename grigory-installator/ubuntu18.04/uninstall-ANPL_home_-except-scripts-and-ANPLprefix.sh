#!/bin/bash



# Too simple, use with caution
# Taken from: http://patorjk.com/software/taag/#p=display&h=2&v=2&c=echo&f=Standard&t=ANPL%20%0AUN-INSTALLER
echo "     _    _   _ ____  _                                               ";
echo "    / \  | \ | |  _ \| |                                              ";
echo "   / _ \ |  \| | |_) | |                                              ";
echo "  / ___ \| |\  |  __/| |___                                           ";
echo " /_/  _\_\_|_\_|_| __|_____| ____ _____  _    _     _     _____ ____  ";
echo " | | | | \ | |    |_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \ ";
echo " | | | |  \| |_____| ||  \| \___ \ | | / _ \ | |   | |   |  _| | |_) |";
echo " | |_| | |\  |_____| || |\  |___) || |/ ___ \| |___| |___| |___|  _ < ";
echo "  \___/|_| \_|    |___|_| \_|____/ |_/_/   \_\_____|_____|_____|_| \_\\";
echo "                                                                      ";
echo
read -p "You are going to remove all folders in ~/ANPL/ except folder 'scripts'. 
         And also remove /usr/ANPLprefix completely. Continue? " yn
case $yn in
        [Yy]* ) cd ~/ANPL
				echo $(ls | sed 's/scripts/ /g') | xargs rm -rf --
				sudo rm -rf /usr/ANPLprefix
				echo "Uninstallation completed :) --->  Enjoy"
				echo -e "\033[0;91m Do not forget to clean '~/.bashrc' file!!! \033[0m"
				gedit ~./bashrc
				echo
echo "      ___           ___                         ___ "
echo "     /  /\         /  /\          ___          /  /\\";
echo "    /  /::\       /  /::|        /  /\        /  /:/";
echo "   /  /:/\:\     /  /:|:|       /  /::\      /  /:/ ";
echo "  /  /::\ \:\   /  /:/|:|__    /  /:/\:\    /  /:/  ";
echo " /__/:/\:\_\:\ /__/:/ |:| /\  /  /::\ \:\  /__/:/   ";
echo " \__\/  \:\/:/ \__\/  |:|/:/ /__/:/\:\_\:\ \  \:\   ";
echo "      \__\::/      |  |:/:/  \__\/  \:\/:/  \  \:\  ";
echo "      /  /:/       |__|::/        \  \::/    \  \:\ ";
echo "     /__/:/        /__/:/          \__\/      \  \:\\";
echo "     \__\/         \__\/                       \__\/";
echo
;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac






