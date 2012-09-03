#!/bin/bash

xrdb -merge ~/.Xresources

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Start DE/WM

case $1 in
xfce)
    exec dbus-launch --exit-with-session startxfce4
    ;;
xmonad)
    xsetroot -cursor_name left_ptr

    pactl load-module module-equalizer-sink&    # Fix me
    pulseaudio --start &                        # Fix me

    keepassx&
    dropboxd&
    deluged

    exec dbus-launch --exit-with-session xmonad
    ;;
esac
