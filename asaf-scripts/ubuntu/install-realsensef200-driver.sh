#!/bin/bash

VERSION=0.3

echo "computer need to restart. please save your work. for restart write yes (yes|no)"
read KEY
#from http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-6.html
#from http://stackoverflow.com/questions/8920245/bash-conditionals-how-to-and-expressions-if-z-var-e-var
if [ ! -z "$KEY" ] && [ $KEY = "yes" ]; then

    echo "Username for 'https://bitbucket.org':"
    #from http://ryanstutorials.net/bash-scripting-tutorial/bash-input.php
    read USERNAME
    echo "Password for 'https://$USERNAME@bitbucket.org':"
    #from http://stackoverflow.com/questions/3980668/how-to-get-a-password-from-a-shell-script-without-echoing
    read -s PASSWORD
    echo "Make sure that the camera is plug in, Press any key when connected"
    #from http://unix.stackexchange.com/questions/134437/press-space-to-continue 
    read -n 1

    cd ~/Downloads
    rm -rf f200_install-v$VERSION.zip f200_install/
    #from http://stackoverflow.com/questions/3082107/how-to-pull-a-bitbucket-repository-without-access-to-hg
    wget -O f200_install-v$VERSION.zip "https://$USERNAME:$PASSWORD@bitbucket.org/ANPL/binaries/raw/master/realsense/f200_install-v$VERSION.zip"
    unzip f200_install-v$VERSION.zip -d .
   
    cd f200_install
    # install in ~/ivcam
	rm -rf ~/ivcam
    sh install.sh ~/ivcam
    
    cd ~/Downloads
    rm -rf f200_install-v$VERSION.zip f200_install/

    sudo reboot
fi

#from http://www.howtogeek.com/179022/how-to-clear-the-terminal-history-on-linux-or-mac-os-x/
# clear command history that other users will not hack and revel passwords. 
history -c
