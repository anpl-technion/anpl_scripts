PREFIX=/usr/ANPLprefix

GTSAM_TOOLBOX_VER="3.2.0"
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-toolbox-$GTSAM_TOOLBOX_VER-lin64.tgz"
FILE_NAME=gtsam-toolbox-$GTSAM_TOOLBOX_VER.tgz
FOLDER_NAME=gtsam_toolbox

sudo rm -rf $PREFIX/$FOLDER_NAME

cd ~/Downloads
wget -O $FILE_NAME $LINK
tar zxvf $FILE_NAME
sudo mv $FOLDER_NAME $PREFIX
rm -rf ~/Downloads/$FILE_NAME

#save matlab the path for gtsam toolbox
sudo matlab -nodesktop -nosplash -r "addpath(genpath('$PREFIX/$FOLDER_NAME'));savepath;exit;"

