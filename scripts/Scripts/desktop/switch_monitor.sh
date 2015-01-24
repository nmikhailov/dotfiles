#!/bin/bash

AUTHPATH=/var/run/xauth/

export DISPLAY=:0
export XAUTHORITY=$AUTHPATH$(ls -t $AUTHPATH | head -n 1)
echo $XAUTHORITY

internal=`xrandr | grep LVDS | sed -e "s/ .*//g"`
externals=('HDMI'   # xf86-video-radeon
           'DFP'   # catalyst
           'VGA'
           'HDMI-0'
           )

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
    xrandr --output $external --auto
    xrandr --output $internal --off
else
    xrandr --output $internal --auto

    for name in "${externals[@]}"
    do
        xrandr --output $name --off
    done
fi
