#!/bin/bash
MATLAB_VER="R2019b"
MATLAB_DIR=/usr/local/MATLAB/$MATLAB_VER

echo "Script installs MATLAB using Academic License provided by Technion Institute on last or penultimate release. If you need to work with some particular version of MATLAB, please *DO NOT USE THE SCRIPT*."
echo "[Importatnt note]: Run the script on computer which is connected *WIREDLY* inside *TECHNION NETWORK*; otherwise the script will freeze."
read -p "Please press 'Y' if you wish to continue" IN
case $IN in
	[Y] ) echo "Installation starts..." ;;
	*) echo "Installtion canceled." ;;
esac 
# Installation Instructions
# ~~~~~~~~~~~~~~~~~~~~~~~~~
WS=$(pwd)
# 1) Login (su) to the root account.
cd /
sudo apt-get install nfs-common -y
# 2) Mount the MATLAB CD on your host:

sudo mkdir /mnt
sudo chmod a+rwx /mnt

sudo mount 132.68.1.41:/ccnfs/cccd/matlab /mnt
case $? in
	0) ;;
	2) echo "##########################################################"
	read -p "Mounting failed due to sysytem error, please rerun $WS/${0##*/} script manually before continue" 
	exit ;;
	*) echo "##########################################################"
	read -p "MATLAB installation failed, please install MATLAB manually before continue" 
	exit ;;
esac

# (Note: on Ubuntu please make sure that nfs-common package is installed.
#        If not, install it by "apt-get install nfs-common".)

#    Verify mount command successful completion:

# 	df -h /mnt
# 	Filesystem			Size  Used Avail Use% Mounted on
# 	132.68.1.41:/ccnfs/cccd/matlab	300G  210G   90G  70% /mnt

MATLAB_VER_SERV=$(head -1 /mnt/version.txt)
# replace version in this condition
if [ "$MATLAB_VER_SERV" -ne "$MATLAB_VER" ] ; then
	echo "\\e[0;41m ERROR: MATLAB Key expired. Version of MATLAB source had changed, please contact IT group of Aerospace Depatment to get new File Activation Key and put it inside '$WS/matlab_files/matlab_installer_input.txt' in appropriate window.\\e[0m"
	echo "You also have to update script 'src/install-matlab-gr.sh' and set the version as it provided on server."
	read -p 'Then rerun the script'
	sudo umount /mnt
	exit
fi

# 3) Download the license file (attached to this mail) and save it as /tmp/network.lic
#    on your host. This is a short network.lic file which should include two lines only:

sudo cp $WS/src/matlab_files/network.lic /tmp/network.lic
sudo cp $WS/src/matlab_files/matlab_installer_input.txt /tmp/installer_input.txt
sudo chmod a+r /tmp/network.lic /tmp/installer_input.txt

sudo /mnt/install -inputFile /tmp/installer_input.txt

# 6) To allow users to run MATLAB, create symbolic links to MATLAB executables
#    (scripts) in /usr/local/bin, as follows:
#    MATLAB_DIR is a full path of MATLAB root directory.
sudo ln -s $MATLAB_DIR/bin/matlab /usr/local/bin/matlab
sudo ln -s $MATLAB_DIR/bin/mex    /usr/local/bin/mex


sudo umount /mnt
