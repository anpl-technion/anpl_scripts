#!/bin/bash

#remove temp files
rm -f *~

#convert scripts to unix format
dos2unix --quiet *.sh

#make scripts executables
chmod +x *.sh
