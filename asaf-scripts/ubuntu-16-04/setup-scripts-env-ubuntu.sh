#!/bin/bash

PROJECT_DIR=~/ANPL
SYSTEM=ubuntu-16-04

echo "export PATH=\$PATH:${PROJECT_DIR}/scripts/$SYSTEM" >> ~/.bashrc
source ~/.bashrc

# arrange scripts (remove temp file, convert to unix format, make executable)
arrange-scripts.sh
