#!/bin/bash
# Init numlockx
internal=`xrandr | grep LVDS | sed -e "s/ .*//g"`
external=`xrandr | grep HDMI | sed -e "s/ .*//g"`
has_external=$(xrandr | grep HDMI | grep " connected" | wc -l)
#echo "Internal: "$internal
#echo "External: "$external
#echo "External2: "$has_external

if [[ $has_external -ne 0 ]]
then
#    echo external mode
    xrandr --output $external --mode "1280x1024"
    xrandr --output $internal --off
else
#    echo internal mode
    xrandr --output $internal --mode "1366x768"
fi
