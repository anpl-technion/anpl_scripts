#!/bin/bash

#from http://askubuntu.com/questions/81293/what-is-the-command-to-update-time-and-date-from-internet
#from http://askubuntu.com/questions/3375/how-to-change-time-zone-settings-from-the-command-line
sudo timedatectl set-timezone Asia/Jerusalem
sudo ntpdate time.nist.gov
