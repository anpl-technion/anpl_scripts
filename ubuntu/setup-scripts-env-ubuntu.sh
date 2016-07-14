#!/bin/bash

PROJECT_DIR=~/ANPL
SYSTEM=ubuntu

echo "export PATH=\$PATH:${PROJECT_DIR}/scripts/$SYSTEM" >> ~/.bashrc
export PATH=$PATH:${PROJECT_DIR}/scripts/$SYSTEM

# arrange scripts (remove temp file, convert to unix format, make executable)
arrange-scripts.sh
