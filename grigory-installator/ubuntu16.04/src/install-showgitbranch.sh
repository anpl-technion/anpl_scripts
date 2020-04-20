#!/bin/bash

####################################################################
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi
####################################################################

case `grep -Fxq "# Show git branch name" ~/.bashrc >/dev/null; echo $?` in
  0)
    read -p "Show git branch name already exists in '~/.bashrc', press enter to continue" NULL
    ;;
  1)
    cat $MY_PATH/showgitbranchname.txt >> ~/.bashrc
    exec bash
    # echo $MY_PATH
    read -p "Added showgitbranchname in bashrc, press enter to continue" NULL
    
    ;;
  *) 
    read -p "Error occurred, press enter to continue" NULL
    ;;
esac

exec bash

