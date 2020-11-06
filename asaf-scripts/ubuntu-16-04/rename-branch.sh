#!/bin/bash

# use this script carefully! 
# use this if you really know what are you doing!
# type: rename-branch.sh <old_branch_name> <new_branch_name>
# danger, it will delete the old_branch!! !!

echo "use this script carefully!"
echo "use this if you really know what are you doing!"
echo "type: rename-branch.sh <old_branch_name> <new_branch_name>"
echo "danger, it will delete the old_branch!! !!"
read -p "Press [Enter] key to start rename branch... or ctrl c for stop!"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "type: rename-branch.sh <old_branch_name> <new_branch_name>"
    exit
fi

git checkout $1
IS_BRANCH_EXISTS=`git rev-parse --verify $1`

if [ -z "$IS_BRANCH_EXISTS" ]; then
    echo $1 branch is not exists 
    exit
fi

# from: https://gist.github.com/lttlrck/9628955
git branch -m $1 $2                 # Rename branch locally    
git push --set-upstream origin $2   # Push the new branch, set local branch to track the new remote
git push origin :$1                 # Delete the old branch
