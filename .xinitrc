#!/bin/bash

# Start DE/WM
DEFAULT_SESSION=xfce
case $1 in
xfce)
    exec dbus-launch --exit-with-session startxfce4
    ;;
xmonad)
    xsetroot -cursor_name left_ptr
    exec ck-launch-session xmonad
    ;;
*)
    exec ck-launch-session $DEFAULT_SESSION
    ;;
esac

