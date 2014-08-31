#!/bin/bash

# Load settings for urxvt and others
xrdb -merge ~/.Xresources

# Xhost perms
xhost +localhost

# Start a D-Bus session
#source /etc/X11/xinit/xinitrc.d/30-dbus

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh )
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

 #Start DE/WM

pulseaudio --start &
xcompmgr
