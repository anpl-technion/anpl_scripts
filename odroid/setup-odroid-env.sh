#!/bin/bash

echo "export PATH=.:\$PATH" >> ~/.bashrc
export PATH=.:$PATH

echo "export PATH=~/ANPL/infrastructureproject/InstallEnvScripts/odroid:\$PATH" >> ~/.bashrc
export PATH=~/ANPL/infrastructureproject/InstallEnvScripts/odroid:$PATH

#from http://www.cmake.org/pipermail/cmake/2008-December/026113.html
echo "export MAKEFLAGS=\"-j1\"" >> ~/.bashrc
export MAKEFLAGS="-j1"

mkdir -p ~/ANPL
mkdir -p ~/prefix

#connect_wifi is runs only onse, so put this script at /etc/rc.local
# cat << EOF > /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
#export HOME=/root
#export USER=root
#/root/ANPL/infrastructureproject/InstallEnvScripts/odroid/wifi-#connect.sh
#/root/ANPL/infrastructureproject/InstallEnvScripts/odroid/update-#time.sh
#/root/ANPL/infrastructureproject/InstallEnvScripts/odroid/#vnc_restart.sh
#exit 0

#EOF

