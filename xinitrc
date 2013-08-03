#!/bin/bash

# Load settings for urxvt and others
xrdb -merge ~/.Xresources

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh )
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

#Start DE/WM

#case $1 in
#xfce)
    #exec dbus-launch --exit-with-session startxfce4
    #;;
#xmonad)
    #pulseaudio --start &
    #xcompmgr &
    #exec dbus-launch --exit-with-session xmonad
    #;;
#dwm)
    #exec dbus-launch --exit-with-session dwm
    #;;
#awesome)
    #exec dbus-launch --exit-with-session awesome
    #;;
#esac
