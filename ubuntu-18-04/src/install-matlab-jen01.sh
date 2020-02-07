#!/bin/bash

# Installation Instructions
# ~~~~~~~~~~~~~~~~~~~~~~~~~
# 1) Login (su) to the root account.
cd /
sudo apt-get install nfs-common
# 2) Mount the MATLAB CD on your host:

sudo mkdir /mnt
sudo chmod a+rwx /mnt

sudo mount 132.68.1.41:/ccnfs/cccd/matlab /mnt

# (Note: on Ubuntu please make sure that nfs-common package is installed.
#        If not, install it by "apt-get install nfs-common".)

#    Verify mount command successful completion:

# 	df -h /mnt
# 	Filesystem			Size  Used Avail Use% Mounted on
# 	132.68.1.41:/ccnfs/cccd/matlab	300G  210G   90G  70% /mnt

# 3) Download the license file (attached to this mail) and save it as /tmp/network.lic
#    on your host. This is a short network.lic file which should include two lines only:

sudo cp ~/ANPL/scripts/ubuntu-16-04/Fullormodolerinstallation/network.lic /tmp/network.lic

echo 00005-16835-26635-50915-34103-49806-00691-03238-60527-20825-20994-49122-40985-07857-10083-41606-05732-42425-22343-15209-09635-36130
echo license dir: /tmp/network.lic

# 	SERVER lm.technion.ac.il 001b24e02dd5 1700
# 	USE_SERVER

# 4) Run the install script and follow the on-screen instructions:

echo 00005-16835-26635-50915-34103-49806-00691-03238-60527-20825-20994-49122-40985-07857-10083-41606-05732-42425-22343-15209-09635-36130
echo /tmp/network.lic
sudo /mnt/install

#    - When prompted to "Select installation method", please choose the "File Installation Key" option.

#    - When prompted to "Provide File Installation Key", please enter:

#<<<<<<< HEAD:ubuntu-16-04/install-matlab-jen01.sh
# 00005-16835-26635-50915-34103-49806-00691-03238-60527-20825-20994-49122-40985-07857-10083-41606-05732-42425-22343-15209-09635-36130

#    - When prompted to "Provide license file location", please enter:
   
#=======
#  00005-16835-26635-50915-34103-49806-00691-03238-60527-20825-20994-49122-40985-07857-10083-41606-05732-42425-22343-15209-09635-36130

#    - When prompted to "Provide license file location", please enter:

## /tmp/network.lic

# 5) Unmount the CD:

sudo umount /mnt

# 6) To allow users to run MATLAB, create symbolic links to MATLAB executables
#    (scripts) in /usr/local/bin, as follows:

	ln -s MATLAB_DIR/bin/matlab /usr/local/bin
	ln -s MATLAB_DIR/bin/mex    /usr/local/bin

#    where MATLAB_DIR is a full path of MATLAB 2018b root directory.