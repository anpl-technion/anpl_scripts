#!/bin/bash
MATLAB_VER="R2019b"

# Installation Instructions
# ~~~~~~~~~~~~~~~~~~~~~~~~~
WS=$(pwd)
# 1) Login (su) to the root account.
cd /
sudo apt-get install nfs-common -y
# 2) Mount the MATLAB CD on your host:

sudo mkdir /mnt/matlab
sudo chmod a+rwx /mnt/matlab

sudo mount 132.68.1.41:/ccnfs/cccd/matlab /mnt/matlab

# (Note: on Ubuntu please make sure that nfs-common package is installed.
#        If not, install it by "apt-get install nfs-common".)

#    Verify mount command successful completion:

# 	df -h /mnt
# 	Filesystem			Size  Used Avail Use% Mounted on
# 	132.68.1.41:/ccnfs/cccd/matlab	300G  210G   90G  70% /mnt

MATLAB_VER_SERV=$(head -1 /mnt/matlab/version.txt)
# replace version in this condition
if [ ! "$MATLAB_VER_SERV" = "$MATLAB_VER" ] ; then
	echo -e "\\e[0;41m ERROR: MATLAB Key expired. Version of MATLAB source had changed from $MATLAB_VER to $MATLAB_VER_SERV, please contact IT group of Aerospace Depatment to get new File Activation Key and put it inside 'src/matlab_files/matlab_installer_input.txt' in appropriate window.\\e[0m"
	echo "You also have to update MATLAB_VER variable inside 'src/install-matlab-gr.sh' script and set it to a version as it provided on server."
	sudo umount /mnt/matlab
	exit
fi

# 3) Download the license file (attached to this mail) and save it as /tmp/network.lic
#    on your host. This is a short network.lic file which should include two lines only:

sudo cp $WS/matlab_files/network.lic /tmp/network.lic
sudo cp $WS/matlab_files/matlab_installer_input.txt /tmp/installer_input.txt
sudo chmod a+r /tmp/network.lic /tmp/installer_input.txt

sudo /mnt/matlab/install -inputFile /tmp/installer_input.txt

# 6) To allow users to run MATLAB, create symbolic links to MATLAB executables
#    (scripts) in /usr/local/bin, as follows:

MATLAB_DIR=/usr/local/MATLAB/$MATLAB_VER

sudo ln -s $MATLAB_DIR/bin/matlab /usr/local/bin
sudo ln -s $MATLAB_DIR/bin/mex    /usr/local/bin

# where MATLAB_DIR is a full path of MATLAB 2018b root directory.


sudo umount /mnt/matlab