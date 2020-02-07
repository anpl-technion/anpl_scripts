#!/bin/bash

cat <<EOT >> ~/.bashrc
echo "\n\n\n\t\t I"M IN SET TITLE WOW\n\n\n"

# function to set terminal title
function title(){
  if [[ -z "\$ORIG" ]]; then
    ORIG="\$PS1"
  fi
  TITLE="\[\e]2;\$*\a\]"
  PS1="\${ORIG}\${TITLE}"
}

EOT

