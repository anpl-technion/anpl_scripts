#!/bin/bash

echo "-----------------------------------"
echo 

case `grep -Fxq "# Show git branch name" ~/.bashrc >/dev/null; echo $?` in
  0)
    echo Show git already exists
    ;;
  1)
    cat src/showgitbranchname.txt >> ~/.bashrc
    echo "Added showgitbranchname in bashrc" 
    source ~/.bashrc
    ;;
  *)
    echo code if an error occurred
    ;;
esac

