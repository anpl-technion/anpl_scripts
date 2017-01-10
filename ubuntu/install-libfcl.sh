PREFIX=~/prefix
PROJECT_NAME=libfcl
GIT_LINK=https://github.com/flexible-collision-library/fcl
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX"
VERSION=0.4

install-gcc4.9.sh

#from https://github.com/flexible-collision-library/fcl

sudo rm -rf $PROJECT_DIR/$PROJECT_NAME

cd $PROJECT_DIR/
git clone $GIT_LINK -b fcl-$VERSION $PROJECT_NAME
cd $PROJECT_NAME
mkdir build
cd build
cmake $CMAKE_FLAGS ..
make -j7
sudo make install -j7
