#!/usr/bin/env python3

import sys
import os
import importlib
from utills import *


print(bcolors.OKGREEN + "Installing ANPL workspace..."+ bcolors.ENDC)
os.system('bash ./src/setup-workspace.sh')
install("cmake-FindIt")

#install modules
print(bcolors.OKGREEN + "Installing essential modules..."+ bcolors.ENDC)
# install("java-jdk")
os.system("sudo apt-get install openssh-server -y")
os.system("sudo apt install curl -y")
os.system("sudo apt install cmake-qt-gui cmake -y")
os.system("sudo apt install graphviz-dev -y")

# ros packages (via apt-get)
print(bcolors.OKGREEN + "Installing ROS and packages..." + bcolors.ENDC)
install("ros-packages")
install("octomap")
install("turtlebot")


# Now we have working directory, ROS and ROS packages installed, it's time to install all the 3rd party dependecies:
print(bcolors.OKGREEN + "Installing 3rd party dependecies..." + bcolors.ENDC)
'''
			Installation is a must
'''
print(bcolors.OKPURP + "Installing CSM..." + bcolors.ENDC)
install("csm")
print(bcolors.OKPURP + "Installing spdlog..." + bcolors.ENDC)
install("libspdlog")
print(bcolors.OKPURP + "Installing GTSAM..." + bcolors.ENDC)
install("toolbox-gtsam")
install("gtsam")
print(bcolors.OKPURP + "Installing OMPL..." + bcolors.ENDC)
install("ompl")
print(bcolors.OKPURP + "Installing Diverse Short Path..." + bcolors.ENDC)
install("diverse-short-path")
print(bcolors.OKPURP + "Installing Plannar ICP..." + bcolors.ENDC)
install("planar-icp")
'''
			Optional installation
'''
if(user_decision("Would you like to install MATLAB?")):
	print(bcolors.OKPURP + "Installing MATLAB..." + bcolors.ENDC)
	install("matlab-gr")

if(user_decision("Would you like to install CUDA?")):
	print(bcolors.OKPURP + "Installing CUDA..." + bcolors.ENDC)
	install("cuda9.2")

if(user_decision("Would you like to install OpenCV?")):
	print(bcolors.OKPURP + "Installing OpenCV..." + bcolors.ENDC)
	install("opencv3")

if(user_decision("Would you like to install vlfeat?")):
	print(bcolors.OKPURP + "Installing vlfeat..." + bcolors.ENDC)
	install("vlfeat")

if(user_decision("Would you like to install PCL?")):
	print(bcolors.OKPURP + "Installing PCL..." + bcolors.ENDC)
	install("libpcl-1.8")

# if(user_decision("Would you like to install CCD?")): [AG needs it]
print(bcolors.OKPURP + "Installing CCD..." + bcolors.ENDC)
install("libccd")

# if(user_decision("Would you like to install FCL?")): [AG needs it]
print(bcolors.OKPURP + "Installing FCL..." + bcolors.ENDC)
install("libfcl")

if(user_decision("Would you like to install ORBSLAM 2?")):
	print(bcolors.OKPURP + "Installing ORBSLAM 2..." + bcolors.ENDC)
	install("orbslam2")

if(user_decision("Would you like to install ZED?")):
	print(bcolors.OKPURP + "Installing ZED..." + bcolors.ENDC)
	install("zed-sdk")

#update a file name database
os.system("sudo updatedb")

print(bcolors.OKGREEN + "Setting up the MRBSP workspace..."+ bcolors.ENDC)
os.system("bash ./src/setup-anpl-mrbsp.sh")
install("mavros")
install("rotors-simulation")

if(user_decision("Would you like to install viso2?")):
	print(bcolors.OKPURP + "Installing viso2..." + bcolors.ENDC)
	install("viso2")

install("rosaria")
install("mocap-optitrack-ros-package")

print(bcolors.OKGREEN + "Building the workspace..."+ bcolors.ENDC)
os.system("bash ./src/build-env.sh")

# Enbling caching of BitBucket's login and password for a half hour(1800 sec) 
os.system("git config --global credential.helper 'cache --timeout 1800'")

print(bcolors.OKGREEN + "Installation of ANPL MRBSP and dependecies is finished!")
print("Do you want to install programs we find usefull for work within our project?")
ans = request_to_user("Do you want to install programms we find usefull for work within our project? [GVim,lyx,smartgit,qgroundcontrol,BCN3D-Cura,sublime,filezila,clion]", ["y", "n"])
if ans == 'y':
	install("GVim")
	install("lyx")
	install("smartgit")
	install("qgroundcontrol")
	install("BCN3D-Cura")
	install("sublime")
	install("filezila")
	print(bcolors.OKPURP + "Last step, please install CLion manually..." + bcolors.ENDC)
	install("clion")
