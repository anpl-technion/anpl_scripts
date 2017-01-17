PREFIX=/usr/ANPLprefix

GTSAM_TOOLBOX_VER="3.2.0"
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release"
LINK="https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-toolbox-$GTSAM_TOOLBOX_VER-lin64.tgz"
FILE_NAME=gtsam-toolbox-$GTSAM_VER.zip


cd ~/Downloads
wget -O $FILE_NAME $LINK
unzip $FILE_NAME -d $PREFIX

#save matlab the path for gtsam toolbox
sudo matlab -nodesktop -nosplash -r "addpath(genpath('$PREFIX/gtsam_toolbox'));savepath;exit;"

