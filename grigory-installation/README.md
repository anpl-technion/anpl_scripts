# Welcome to Infrastracture Installer! 

## Grigory installer
### Installer overview
Full documentation on [wiki page]((https://bitbucket.org/ANPL/anpl_scripts/wiki/Installation-script.md).  
Scripts inside the directory are mainly focused on installation of minimal dependency set for the infrustruture. The scripts are recommended to use on a clean machine, when no dependencies are preinstalled. [**Remark**: Scripts are intended only for 16.04 and 18.04 Ubuntu distributions]  
Directory organization: `min-installation.sh` is the installation launcher. The script invokes single-dependency installation scripts from `src` subfolder. 

Script `min-installation.sh` is self explanatory and also designate the way each dependency is installed. Further explainations are placed on [wiki](https://bitbucket.org/ANPL/anpl_scripts/wiki/Installation-script.md).

The `src` subfolder contains modified and updated scripts from `asaf-scripts/ubuntu16.04`, which were adjusted for both Ubuntu 16.04 and 18.04. `uninstaller-script.sh` completely removes the infrastructure and all from-source dependencies, be afraid to use the script. 

**Important:** if you want to run a script from `src` directory, make sure you run it from insude `grigory-installation/src`. 

 
### Available Configurations
Full documentation on configurations could be found on [wiki page](https://bitbucket.org/ANPL/anpl_scripts/wiki/Configurations.md).  
The ANPL project is distributed in several configurations: **INF_VERSION - INF_BRANCH - GTSAM_VER**. 

* mrbsp_ros - LiDAR branch - GTSAM3 

* mrbsp_ros - Vision branch - GTSAM3 

* anpl_mrbsp - LiDAR branch - GTSAM3 

* anpl_mrbsp - LiDAR branch - GTSAM4 

This repository provides installation scripts for variety of configurations for ANPL infrastructure. 

## Installation
Depending on working machine's OS, move to appropriate directory, launch `installer-script.sh` and follow script prints.

```bash
cd ~/ANPL/scripts/grigory-installer/ubuntu16.04
bash installer-script.sh
```

## Uninstallation
If you would like to remove the **entire** infrastructure, you could launch `unistaller-script.sh`.

** Aware using this script!** 

*The script **erases entire** `/usr/ANPLprefix` directory, so other users on your machine will be affected by the action!* Example of recomended usage

```bash
sudo cp /usr/ANPLprefix /usr/ANPLprefix[backup]
bash uninstaller-script.sh
```

## Archive
Archives could be found in subfolders. It stores files and scripts which might be helpfull for further repo maintaining. Scripts are not promissed to work correctly or with no errors. 
