#!/bin/bash

# Get monitor width and height for proper Layout
SCREEN_WIDTH=$(xrandr | grep -Po --color=never "(?<=\ connected )[\d]+(?=x[\d]+)")
SCREEN_HEIGHT=$(xrandr | grep -Po --color=never "(?<=\ connected )[\d]+x[\d]+" | sed -r "s/[0-9]+x//")

# Panel Layouts
HEIGHT=16 # Panel height
TOP_LEFT_WIDTH=700
BOTTOM_LEFT_WIDTH=700

# Progress bar settings
BAR_H=9
BIGBAR_W=65
WIDTH_L=825
X_POS_L=0
X_POS_R=$WIDTH_L
Y_POS=0

#Colors and font
CRIT="#99cc66"
BAR_FG="#3955c4"
BAR_BG="#363636"
DZEN_FG="#9d9d9d"
DZEN_FG2="#444444"
DZEN_BG="#020202"
COLOR_SEP=$DZEN_FG2
FONT="-*-montecarlo-medium-r-normal-*-11-*-*-*-*-*-*-*"

INTERVAL=0.5
