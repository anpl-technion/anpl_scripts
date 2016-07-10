#!/bin/bash

#from http://superuser.com/questions/549386/what-is-the-correct-way-to-kill-a-vncsession-in-linux
#from http://stackoverflow.com/questions/4162821/bash-foreach-loop
LIST=`ps ax | grep vnc | grep -Eo "Xtightvnc :[0-9]+" | cut -d ":" -f2`

for item in $LIST; do
    tightvncserver -kill :$item
done

