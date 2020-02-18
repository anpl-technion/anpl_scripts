#!/bin/bash
GIT_SCRIPTS="https://bitbucket.org/ANPL/anpl_scripts -b grigory-inst"

cd
mkdir -p ANPL/scripts && cd ~/ANPL
git clone $GIT_SCRIPTS scripts 

# going to dir where "helper.sh" is.
cd $(find ~/ -name "helper.sh" | sed 's/helper.sh//g')


