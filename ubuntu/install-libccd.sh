PREFIX=~/prefix
PROJECT_NAME=libccd
GIT_LINK=https://github.com/danfis/libccd
PROJECT_DIR=~/ANPL/code/3rdparty
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX"


sudo rm -rf $PROJECT_DIR/$PROJECT_NAME

cd $PROJECT_DIR/
git clone $GIT_LINK
cd $PROJECT_NAME
mkdir build
cd build
cmake $CMAKE_FLAGS ..
make -j4
sudo make install -j4


