PREFIX=/usr/local
PROJECT_DIR=~/ANPL/code/3rdparty
BOOST_VER=1.57.0
BOOST_VER_STR=`echo $BOOST_VER | tr . _`
FOLDER_NAME=boost_$BOOST_VER_STR
FILE_NAME=$FOLDER_NAME.zip

LINK=https://netix.dl.sourceforge.net/project/boost/boost/$BOOST_VER/boost_$BOOST_VER_STR.zip
PROJECT_DIR=~/ANPL/code/3rdparty
BOOST_FLAGS="--prefix=$PREFIX"

install-gcc4.9.sh

sudo rm -rf $PROJECT_DIR/$FOLDER_NAME
cd ~/Downloads
wget -O $FILE_NAME $LINK
mkdir -p $PROJECT_DIR
unzip $FILE_NAME -d $PROJECT_DIR
rm -f ~/Downloads/$FILE_NAME
cd $PROJECT_DIR/$FOLDER_NAME

./bootstrap.sh $BOOST_FLAGS
./b2
sudo ./b2 install

install-gcc5.sh
