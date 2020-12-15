# Welcome to ANPL scripts

## Table of context
1. [Overview](#markdown-header-overview)
2. [Installation of MRBSP infrastructure on a clean computer](#markdown-header-installation-of-mrbsp-infrastructure-on-a-clean-computer)
3. [Asaf Scripts](#markdown-header-asaf-scripts)
4. [Grigory installer](#markdown-header-grigory-installer)  
4.1 [Installer Overview](#markdown-header-installer-overview)  
4.2 [Available Configurations](#markdown-header-available-configurations)  

## Overview
The MRBSP project is supplied with installation scripts to simplify the stage of the set up. Some scripts are particular library/dependency installations, another script installs minimal dependency set for the given project configuration defined by ubuntu distribution, *mrbsp* infrastructure and its branch. 

## Installation of MRBSP infrastructure on a clean computer
```
git clone https://bitbucket.org/ANPL/anpl_scripts ~/ANPL/scripts
cd ~/ANPL/scripts/grigory-installation 
bash min-installation.sh
```
This will download ANPL's scripts repository inside `ANPL/scripts` at user's home directory and invokes the minimal installation script. It will propose you to specify [configuration](#markdown-header-available-configurations) for your work: MRBSP infrastructure, ready-to-run branches, set of robots and sensors to work with. This will install minimal dependency set to work with infrastructure.  
However, it does not installs optional programs and tool like MATLAB, PyCharm or SmartGit. Look up inside `src` sub-directory for optional tool installations scripts.

***

## Asaf scripts
The directory contains single-dependency installation scripts for a different types of machines presented in the lab: Ubuntu, Jetson, Windows and odroid. The directory was not leaded for a long time, part of the scripts might be outdated. 

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
