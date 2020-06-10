#!/bin/bash

echo "-----------------------------------"
echo 

case `grep -Fxq "# Show git branch name" ~/.bashrc >/dev/null; echo $?` in
  0)
    echo Show git already exists
    ;;
  1)
    cat showgitbranchname.txt >> ~/.bashrc
    read -p "Added showgitbranchname in bashrc" NULL
    source ~/.bashrc
    ;;
  *)
    echo code if an error occurred
    ;;
esac

