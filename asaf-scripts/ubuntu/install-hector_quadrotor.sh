PROJECT_DIR=~/ANPL
PROJECT_PATH=$PROJECT_DIR/hector_quadrotor

#from http://wiki.ros.org/hector_gazebo
#from http://wiki.ros.org/hector_quadrotor
#from http://wiki.ros.org/geographic_msgs
#from http://wiki.ros.org/unique_identifier
#from http://wiki.ros.org/hardware_interface
#from http://wiki.ros.org/realtime_tools
#from http://wiki.ros.org/gazebo_ros_control
#from http://wiki.ros.org/control_toolbox

rm      -rf ${PROJECT_PATH}/
mkdir   -p  ${PROJECT_PATH}/src
cd          ${PROJECT_PATH}/src
git clone -b indigo-devel https://github.com/tu-darmstadt-ros-pkg/hector_gazebo.git
git clone -b indigo-devel https://github.com/tu-darmstadt-ros-pkg/hector_models.git 
git clone                 https://github.com/ros-geographic-info/geographic_info.git
git clone                 https://github.com/ros-geographic-info/unique_identifier.git

cd ${PROJECT_PATH}
catkin_make

cd          ${PROJECT_PATH}/src
git clone -b catkin       https://github.com/tu-darmstadt-ros-pkg/hector_localization.git 
git clone -b indigo-devel https://github.com/ros-controls/ros_control
git clone -b indigo-devel https://github.com/ros-controls/realtime_tools.git
git clone -b indigo-devel https://github.com/ros-simulation/gazebo_ros_pkgs.git
git clone -b indigo-devel https://github.com/ros-controls/control_toolbox.git
git clone -b indigo-devel https://github.com/tu-darmstadt-ros-pkg/hector_quadrotor.git 

cd ${PROJECT_PATH}
catkin_make

echo "source $PROJECT_PATH/devel/setup.bash" >> ~/.bashrc
source $PROJECT_PATH/devel/setup.bash
