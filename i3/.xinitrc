#!/bin/bash
 #Start DE/WM

pulseaudio --start &
xcompmgr &
exec dbus-launch --exit-with-session i3
