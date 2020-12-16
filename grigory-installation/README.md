# Welcome to Infrastracture Installer! 

## Grigory installer
### Installer overview
Full documentation on [wiki page](https://bitbucket.org/ANPL/anpl_scripts/wiki/Installation-script.md).  
Scripts inside the directory are mainly focused on installation of minimal dependency set for the infrustruture. If you run the script on a clean machine, when no dependencies are preinstalled, its recommended to run `min-machine-installation.sh`, otherwise run `new-user-installation` to not screw up others conputer users work. [**Remark**: Scripts are intended only for 16.04 and 18.04 Ubuntu distributions]  
Directory organization: `new-machine-installation.sh` is the installation launcher. The script installs the infrastructure and invokes single-dependency installation scripts from `src` subfolder.  
`new-user-installation.sh` only make packages accessible for a new user and installs infrastructure and robots+sensors specified by the user. 
Script `new-machine-installation.sh` is self explanatory and also designate the way each dependency is installed. Further explainations are placed on [wiki](https://bitbucket.org/ANPL/anpl_scripts/wiki/Installation-script.md)

The `src` subfolder contains modified and updated scripts from `asaf-scripts/ubuntu16.04`, which were adjusted for both Ubuntu 16.04 and 18.04. `uninstaller-script.sh` completely removes the infrastructure and all from-source dependencies, be afraid to use the script. 

The `apps` subfolder contains installation scripts for tool that are not essential project dependecies. You could find installation of MATLAB, LyX and many others inside of this folder. 

**Important:** if you want to run a script from `src` directory, make sure you run it from insude `grigory-installation/src`. 

 
### Available Configurations
Full documentation on configurations could be found on [wiki page](https://bitbucket.org/ANPL/anpl_scripts/wiki/Configurations.md).  
The ANPL project is distributed in several configurations: **INF_VERSION - INF_BRANCH - GTSAM_VER**. 

* mrbsp_ros - LiDAR branch - GTSAM3 

* mrbsp_ros - Vision branch - GTSAM3 

* anpl_mrbsp - LiDAR branch - GTSAM3 

* anpl_mrbsp - LiDAR branch - GTSAM4 

This repository provides installation scripts for variety of configurations for ANPL infrastructure. 