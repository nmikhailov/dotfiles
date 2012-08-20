#!/bin/bash
# Init numlockx
internal=`xrandr | grep LVDS | sed -e "s/ .*//g"`
external=`xrandr | grep VGA | sed -e "s/ .*//g"`
#echo "Internal: "$internal
#echo "External: "$external

if [ $external ]
then
#    echo external mode
    xrandr --output $external --mode "1280x1024"
    xrandr --output $internal --off
else
#    echo internal mode
    xrandr --output $internal --mode "1366x768"
fi
