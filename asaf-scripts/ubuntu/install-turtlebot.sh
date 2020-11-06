#!/bin/bash

#from http://wiki.ros.org/indigo/Installation/Ubuntu
#Setup your sources.list at Ubuntu 14.04 (Trusty)
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
#Set up your keys
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
#Installation
sudo apt-get update

#from http://wiki.ros.org/turtlebot/Tutorials/indigo/Installation
#Preparation
sudo apt-get install python-rosdep python-wstool ros-indigo-ros -y
sudo rosdep init
rosdep update

#Workspaces
mkdir ~/rocon
cd ~/rocon
wstool init -j5 src https://raw.github.com/robotics-in-concert/rocon/indigo/rocon.rosinstall
source /opt/ros/indigo/setup.bash
rosdep install --from-paths src -i -y
catkin_make

mkdir ~/kobuki
cd ~/kobuki
wstool init src -j5 https://raw.github.com/yujinrobot/yujin_tools/master/rosinstalls/indigo/kobuki.rosinstall
source ~/rocon/devel/setup.bash
rosdep install --from-paths src -i -y
catkin_make

mkdir ~/turtlebot
cd ~/turtlebot
wstool init src -j5 https://raw.github.com/yujinrobot/yujin_tools/master/rosinstalls/indigo/turtlebot.rosinstall
source ~/kobuki/devel/setup.bash
rosdep install --from-paths src -i -y -f
catkin_make

#for kobuki base
source ~/turtlebot/devel/setup.bash
rosrun kobuki_ftdi create_udev_rules

echo "source ~/turtlebot/devel/setup.bash" >> ~/.bashrc

#from http://wiki.ros.org/turtlebot/Tutorials/indigo/Workstation%20Installation
#Network Time Protocol
sudo apt-get install chrony -y
sudo ntpdate ntp.ubuntu.com

#from http://askubuntu.com/questions/432732/fatal-error-gl-glut-h-no-such-file-or-directory
#from http://www.prinmath.com/csci5229/misc/install.html
#Installing OpenGL 
sudo apt-get install freeglut3-dev -y

#from https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get
#install javac (jdk)
sudo apt-get install default-jdk -y

#install doxygen
sudo apt-get install doxygen -y

#remove first then install
sudo apt-get remove ros-indigo-openni-camera -y
sudo apt-get remove ros-indigo-openni-launch -y
sudo apt-get remove openni-dev -y

#from http://answers.ros.org/question/53706/registered-depth-image-is-black/
#To install openni
mkdir ~/kinect 
cd ~/kinect
git clone https://github.com/OpenNI/OpenNI.git -b unstable
cd OpenNI/Platform/Linux/CreateRedist
bash RedistMaker
cd ../Redist/OpenNI-Bin-Dev-Linux-x86*/
sudo ./install.sh

#install kinect sensor
cd ~/kinect
#from https://aur.archlinux.org/packages/sensorkinect-git/
git clone https://github.com/ph4m/SensorKinect
cd SensorKinect/Platform/Linux/CreateRedist
bash RedistMaker
cd ../Redist/Sensor-Bin-Linux-x86*
sudo sh install.sh

#from http://wiki.ros.org/openni_camera
#openni-camera
sudo apt-get install ros-indigo-openni-camera -y

#openni_launch
sudo apt-get install ros-indigo-openni-launch -y

#from http://answers.ros.org/question/182030/could-not-find-executable-running-image_view-from-rosrun/
#install image view
sudo apt-get install ros-indigo-image-view -y
