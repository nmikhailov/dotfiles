#!/bin/bash

internal=`xrandr | grep LVDS | sed -e "s/ .*//g"`
externals=('HDMI'   # xf86-video-radeon
           'DFP')   # catalyst

for name in "${externals[@]}"
do
    exist=$(xrandr | grep $name | grep " connected")

    if [ -n "$exist" ]
    then
        external=`xrandr | grep $name | sed -e "s/ .*//g"`
        break
    fi
done

if [ -n "$external" ]
then
    xrandr --output $external --mode "1280x1024"
    xrandr --output $internal --off
else
    xrandr --output $internal --mode "1366x768"
fi
