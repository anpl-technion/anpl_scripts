#!/bin/bash
URL=https://bitbucket.org/ANPL/infrastructureproject.git
PROJECT_DIR=~/ANPL
#from http://stackoverflow.com/questions/600079/is-there-any-way-to-clone-a-git-repositorys-sub-directory-only

#delete old repository
cd ${PROJECT_DIR}/catkin_ws/src
rm -rf .git gtsam_infrastructure/ .gitignore

#creates an empty repository with your remote. at ~/prefix/catkin_ws/src
cd ${PROJECT_DIR}/catkin_ws
git init src
cd src
git remote add -f origin $URL

#add sparsecheckout
git config core.sparsecheckout true

#add gtsam_infrastructure folder to checkout.
echo gtsam_infrastructure>> .git/info/sparse-checkout

# git pull
git pull origin master

#setup gitignore for this folder only.
echo \*>&  .gitignore
echo \!gtsam_infrastructure/\*>> .gitignore


#git setup branch to pull/merge
#from http://stackoverflow.com/questions/10147475/git-checkout-tag-git-pull-fails-in-branch
git branch --set-upstream-to=origin/master master

