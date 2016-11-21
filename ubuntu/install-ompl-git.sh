#!/bin/bash
#from http://ompl.kavrakilab.org/download.html

PREFIX=~/prefix
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DOMPL_BUILD_DEMOS=OFF -DOMPL_BUILD_PYBINDINGS=OFF -DOMPL_BUILD_PYTESTS=OFF -DOMPL_REGISTRATION=OFF" 
FROM_GIT=True
OMPL_VER="1.2.1"
PROJECT_DIR=~/ANPL/code/3rdparty

#from http://ompl.kavrakilab.org/installation.html

#Install Boost, CMake, Python, PyQt4, PyOpenGL, and pkg-config.
sudo apt-get install libboost-all-dev cmake python-dev python-qt4-dev python-qt4-gl python-opengl freeglut3-dev libassimp-dev -y

#To be able to generate documentation and build the OpenDE extension, the following packages are also needed:
sudo apt-get install doxygen graphviz libode-dev -y 

sudo rm -rf $PROJECT_DIR/ompl-$OMPL_VER
cd $PROJECT_DIR

if [ "$FROM_GIT" = True ]; then
	git clone -b $OMPL_VER https://github.com/ompl/ompl ompl-$OMPL_VER
	cd ompl-$OMPL_VER
else
	cd ~/Downloads
	wget -O omplapp-$OMPL_VER.zip "https://bitbucket.org/ompl/ompl/downloads/ompl-$OMPL_VER-Source.zip"
	unzip omplapp-$OMPL_VER.zip -d $PROJECT_DIR
	rm -f ~/Downloads/omplapp-$OMPL_VER.zip

	mv $PROJECT_DIR/ompl-$OMPL_VER-Source $PROJECT_DIR/ompl-$OMPL_VER
	cd $PROJECT_DIR/ompl-$OMPL_VER
fi


mkdir -p build-release
cd build-release
cmake $CMAKE_FLAGS ..

install-gcc4.9.sh

#If you want Python bindings or a GUI, type the following two commands:
sudo make install -j4

install-gcc4.7.sh
