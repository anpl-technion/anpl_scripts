PREFIX=/usr/ANPLprefix
FROM_GIT=true
OMPL_VER="1.4.2"
PROJECT_DIR=~/ANPL/code/3rdparty
PROJECT_NAME=ompl
SUB_PROJECT_NAME=ompl
FOLDER_NAME=$PROJECT_NAME-$OMPL_VER
FILE_NAME=$FOLDER_NAME.zip
CMAKE_FLAGS="-DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DOMPL_BUILD_DEMOS=OFF -DOMPL_BUILD_PYBINDINGS=OFF -DOMPL_BUILD_PYTESTS=OFF -DOMPL_REGISTRATION=OFF -DOMPL_BUILD_TESTS=OFF"

GIT_LINK="https://github.com/ompl/omplapp.git"
SUB_GIT_LINK="https://github.com/ompl/ompl.git"
FILE_LINK=https://bitbucket.org/ompl/ompl/downloads/ompl-$OMPL_VER-Source.zip


# Argument read.
# Script gets single argument or none.
#   --apt=<bool>    Set 'true' if you want to install the package from apt
# If no argument provided default value is used (false)

RED='\033[0;31m' # Red color text
NC='\033[0m' # No Color
if [ "$#" -eq  "0" ]; then
    FROM_APT=false
else
    if [ "$#" -eq  "1" ]; then
        #FROM_APT=$(echo $1 | sed "s/^--apt=\(.*\)$/\1/")
        case $1 in
            --apt=*)
                FROM_APT="${1#*=}"
                if [[ $FROM_APT != true && $FROM_APT != false ]]; then
                    echo -e "${RED}ERROR at '${0##*/}': ${NC}\n$1: Unknown argument, BOOL expected. Please rerun script with 1 argument: --apt=<bool>"
                    exit
                fi
            ;;
            *)
                echo -e "${RED}ERROR at '${0##*/}': ${NC}\n$1: Unknown argument provided. Please rerun script with 1 argument: --apt=<bool>"
                exit
            ;;
        esac
    else
        echo "${RED}ERROR at '${0##*/}': ${NC}\n Too many arguments provided. Please rerun script with 1 argument: --apt=<bool>"
        exit
    fi
fi

if [ "$FROM_APT" = true ]; then
    # sudo apt-get autoremove libompl-dev 
    sudo apt-get install libompl-dev -y
    cd /usr/share/ompl
    sudo cp ompl-config.cmake FindOMPL.cmake
else
    #from: http://ompl.kavrakilab.org/download.html
    sudo rm -rf $PROJECT_DIR/$FOLDER_NAME

    if [ $FROM_GIT = true ]; then
        cd $PROJECT_DIR
        git clone $GIT_LINK -b $OMPL_VER $FOLDER_NAME
        
        cd $FOLDER_NAME
        git clone $SUB_GIT_LINK -b $OMPL_VER $SUB_PROJECT_NAME
    else
        cd ~/Downloads
        wget -O $FILE_NAME $FILE_LINK
        unzip $FILE_NAME -d $PROJECT_DIR
        rm -f ~/Downloads/$FILE_NAME
        cd $PROJECT_DIR/
        mv $FOLDER_NAME-Source $FOLDER_NAME
    fi

    #Hack that make omplapp find libccd and libfcl
    cd ~/Downloads
    wget -L https://raw.githubusercontent.com/dartsim/dart/master/cmake/Findccd.cmake -O FindCCD.cmake
    wget -L https://raw.githubusercontent.com/dartsim/dart/master/cmake/Findfcl.cmake -O FindFCL.cmake
    mv FindCCD.cmake FindFCL.cmake $PROJECT_DIR/$FOLDER_NAME/CMakeModules 

    cd $PROJECT_DIR/$FOLDER_NAME
    mkdir build && cd build
    cmake $CMAKE_FLAGS ..
    make -j4      
    sudo make install -j4
fi


