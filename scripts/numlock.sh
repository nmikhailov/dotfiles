#!/bin/bash
# Init numlock
if [[ `lsusb | grep -i "keyboard" | wc -l` -ge 1 ]]
then
    numlockx on
else
    numlockx off
fi
