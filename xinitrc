#!/bin/bash

xrdb -merge ~/.Xresources

# Start DE/WM
DEFAULT_SESSION=xfce
case $1 in
xfce)
    exec dbus-launch --exit-with-session startxfce4
    ;;
xmonad)
    xsetroot -cursor_name left_ptr

    pactl load-module module-equalizer-sink&    # Fix me
    pulseaudio --start &                        # Fix me

    exec dbus-launch --exit-with-session xmonad
    ;;
*)
    exec ck-launch-session $DEFAULT_SESSION
    ;;
esac
