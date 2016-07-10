#!/bin/bash

printf "Username for 'https://bitbucket.org': "
#from http://ryanstutorials.net/bash-scripting-tutorial/bash-input.php
read USERNAME
printf "Password for 'https://$USERNAME@bitbucket.org': "
#from http://stackoverflow.com/questions/3980668/how-to-get-a-password-from-a-shell-script-without-echoing
read -s PASSWORD

#from http://stackoverflow.com/questions/11506124/how-to-enter-command-with-password-for-git-pull

cd ~/ANPL/catkin_ws/src
git clean -df
git checkout -- .
git pull https://$USERNAME:$PASSWORD@bitbucket.org/ANPL/infrastructureproject

cd ~/ANPL/infrastructureproject/
git clean -df
git checkout -- .
git pull https://$USERNAME:$PASSWORD@bitbucket.org/ANPL/infrastructureproject

#from http://www.howtogeek.com/179022/how-to-clear-the-terminal-history-on-linux-or-mac-os-x/
# clear command history that other users will not hack and revel passwords. 
history -c
