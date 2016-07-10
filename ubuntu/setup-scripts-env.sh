#!/bin/bash

PROJECT_DIR=~/ANPL

echo "export PATH=\$PATH:${PROJECT_DIR}/scripts/ubuntu" >> ~/.bashrc
export PATH=$PATH:${PROJECT_DIR}/scripts/ubuntu

# arrange scripts (remove temp file, convert to unix format, make executable)
arrange-scripts.sh
