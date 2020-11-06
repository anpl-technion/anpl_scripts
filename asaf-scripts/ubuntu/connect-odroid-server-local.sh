#!/bin/bash

#from http://stackoverflow.com/questions/12202587/automatically-enter-ssh-password-with-script
echo "need to run 'install-sshpass.sh' script for connect"
sshpass -p "odroid" ssh -X root@odroid-server.local
