#!/bin/bash

# gtsam
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/ANPLprefix/lib" >>~/.bashrc

# cuda
echo "export PATH=\$PATH:/usr/local/cuda/bin/" >>~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >>~/.bashrc

# ros kinetic
echo "source /opt/ros/kinetic/setup.bash" >>~/.bashrc




