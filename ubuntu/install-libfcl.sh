PREFIX=~/prefix
PROJECT_NAME=libfcl
GIT_LINK=https://github.com/flexible-collision-library/fcl
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX"

install-gcc4.9.sh

#from https://github.com/flexible-collision-library/fcl

sudo rm -rf $PROJECT_DIR/$PROJECT_NAME

cd $PROJECT_DIR/
git clone $GIT_LINK $PROJECT_NAME
cd $PROJECT_NAME
mkdir build
cd build
cmake $CMAKE_FLAGS ..
make -j4
sudo make install -j4


