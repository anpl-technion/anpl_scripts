# Welcome to Infrastracture Installer! 

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

*The script **erases entire** '/usr/ANPLprefix' directory, so other users on your machine will be affected by the action!* Example of recomended usage

```bash
sudo cp /usr/ANPLprefix /usr/ANPLprefix[backup]
bash uninstaller-script.sh
```

## Archive
Archives could be found in subfolders. It stores files and scripts which might be helpfull for further repo maintaining. Scripts are not promissed to work correctly or with no errors. 
