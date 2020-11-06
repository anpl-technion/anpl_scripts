#!/bin/bash


PREFIX=/usr/ANPLprefix
PROJECT_NAME=diverse_short_paths
MAKE_FLAGS="CXXFLAGS=-Wall CXXFLAGS+=-Wextra CXXFLAGS+=-std=c++0x CXXFLAGS+=-O3 CXXFLAGS+=-march=native LOCALINC=-I/usr/ANPLprefix/include LOCALINC+=-Iinclude LOCALINC+=-I/usr/include/eigen3/ LOCALLIB=-L/usr/ANPLprefix/lib -j4"
OBJ_REMOVE="Main.o"

LINK=https://bitbucket.org/ANPL/diverse_short_paths
PROJECT_NAME=diverse_short_paths
PROJECT_DIR=~/ANPL/code/3rdparty

#remove project
rm -rf $PROJECT_DIR/$PROJECT_NAME

cd $PROJECT_DIR

while [ ! -d "$PROJECT_DIR/$PROJECT_NAME" ]; do
git clone $LINK $PROJECT_NAME
done

cd $PROJECT_DIR/$PROJECT_NAME
make $MAKE_FLAGS
cd $PROJECT_DIR/$PROJECT_NAME/build/src
OBJ=`echo *.o`
OBJ=${OBJ//$OBJ_REMOVE/}
sudo ar rvs diverse_short_paths.a $OBJ

sudo mkdir -p $PREFIX/include/$PROJECT_NAME

sudo cp -r $PROJECT_DIR/$PROJECT_NAME/include/* ${PREFIX}/include/$PROJECT_NAME
sudo cp $PROJECT_DIR/$PROJECT_NAME/build/src/diverse_short_paths.a ${PREFIX}/lib

