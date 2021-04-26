# Welcome to ANPL scripts

## Table of context
1. [Overview](#markdown-header-overview)
2. [Installation of MRBSP infrastructure on a clean computer](#markdown-header-installation-of-mrbsp-infrastructure-on-a-clean-computer)
3. [Installer Overview](#markdown-header-installer-overview)  
4. [Available Configurations](#markdown-header-available-configurations)  

## Overview
The MRBSP project is supplied with installation scripts to simplify the stage of the set up. Some scripts are particular library/dependency installations, another script installs minimal dependency set for the given project configuration defined by ubuntu distribution, *mrbsp* infrastructure and its branch. 

## Installation of MRBSP infrastructure on a clean computer
```
git clone https://github.com/anpl-technion/scripts.git ~/ANPL/scripts
cd ~/ANPL/scripts
bash new-machine-installation.sh
```
This will download ANPL's scripts repository inside `ANPL/scripts` at user's home directory and invokes the minimal installation script. It will propose you to specify [configuration](#markdown-header-available-configurations) for your work: MRBSP infrastructure, ready-to-run branches, set of robots and sensors to work with. This will install minimal dependency set to work with infrastructure.  
However, it does not installs optional programs and tool like MATLAB, PyCharm or SmartGit. Look up inside `src` sub-directory for optional tool installations scripts.

***

## Installer overview
Full documentation on [wiki page](https://github.com/anpl-technion/anpl_scripts/wiki/Installation-script.md).  
Scripts inside the directory are mainly focused on installation of minimal dependency set for the infrustruture. If you run the script on a clean machine, when no dependencies are preinstalled, its recommended to run `new-machine-installation.sh`, otherwise run `new-user-installation` to not screw up others conputer users work. [**Remark**: Scripts are intended only for 16.04 and 18.04 Ubuntu distributions]  
Directory organization: `new-machine-installation.sh` is the installation launcher. The script installs the infrastructure and invokes single-dependency installation scripts from `src` subfolder.  
`new-user-installation.sh` only make packages accessible for a new user and installs infrastructure and robots+sensors specified by the user. 
Script `new-machine-installation.sh` is self explanatory and also designate the way each dependency is installed. Further explainations are placed on [wiki](https://github.com/anpl-technion/anpl_scripts/wiki/Installation-script.md)

The `apps` subfolder contains installation scripts for tool that are not essential project dependecies. You could find installation of MATLAB, LyX and many others inside of this folder. 

**Important:** if you want to run a script from `src` directory, make sure you run it from insude `src/`. 

 
## Available Configurations
Full documentation on configurations could be found on [wiki page](https://github.com/anpl-technion/anpl_scripts/wiki/Configurations.md).  
The ANPL project is distributed in several configurations: **INF_BRANCH - GTSAM_VER**. 

* anpl_mrbsp - LiDAR branch - GTSAM3 

* anpl_mrbsp - LiDAR branch - GTSAM4 
