#!/bin/bash
#Layout
BAR_H=9
BIGBAR_W=65
WIDTH_L=825
HEIGHT=16
X_POS_L=0
X_POS_R=$WIDTH_L
Y_POS=0
# Get monitor width and height for proper Layout
SCREEN_WIDTH=$(xrandr | grep -Po --color=never "(?<=\ connected )[\d]+(?=x[\d]+)")
# Layout
WIDTH_R=$(echo "$SCREEN_WIDTH - $WIDTH_L" | bc)

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

printVolInfo() {
    Perc=$(amixer get Master | grep "Left:" | awk '{print $5}' | tr -d '[]%')
    Mute=$(amixer get Master | grep "Left:" | awk '{print $7}')
    echo -n "^fg($DZEN_FG2) VOL "
    if [[ $Mute == "[off]" ]]; then
        echo -n "$(echo $Perc | gdbar -fg $CRIT -bg $BAR_BG -h $BAR_H -w $BIGBAR_W -s o -ss 1 -sw 2 -nonl) "
        echo -n "^fg()off"
    else
        echo -n "$(echo $Perc | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BIGBAR_W -s o -ss 1 -sw 2 -nonl) "
        echo -n "^fg()${Perc}%"
    fi
    return
}

printCPUInfo() {
    cpu="$(awk 'BEGIN{i=0}
            {sum[i]=$2+$3+$4+$5; idle[i++]=$5}
    END {printf "%03d\n", 100*( (sum[1]-sum[0]) - (idle[1]-idle[0]) ) / (sum[1]-sum[0])}
    ' <( head -n 1 /proc/stat; sleep 0.5; head -n 1 /proc/stat))"

    [[ $cpu -gt 70 ]] && cpu="^fg($CRIT)$cpu^fg()"
    echo -n " ^fg($DZEN_FG2)CPU ^fg($BAR_FG)${cpu}%"
    return
}

printTempInfo() {
    CPUTemp0=$(acpi --thermal  | grep "0:" | awk '{print substr($4,0,2)}')
    CPUTemp1=$(acpi --thermal  | grep "1:" | awk '{print substr($4,0,2)}')
    [[ $CPUTemp0 -gt 70 ]] && CPUTemp0="^fg($CRIT)$CPUTemp0^fg()"
    [[ $CPUTemp1 -gt 70 ]] && CPUTemp1="^fg($CRIT)$CPUTemp1^fg()"
    echo -n "^fg($DZEN_FG2)TEMP ^fg($BAR_FG)${CPUTemp0}°^fg($DZEN_FG2)/^fg($BAR_FG)${CPUTemp1}°"
    return
}

printMemInfo() {
    mem="$(awk '/^-/ {print $3}' <(free -m))"

    [[ $mem -gt 70 ]] && mem="^fg($CRIT)$mem^fg()"
    echo -n "^fg($DZEN_FG2)MEM ^fg($BAR_FG)${mem}%"
    return
}

printDropBoxInfo() {
    DropboxON=$(ps -A | grep -c dropbox)
    if [[ $DropboxON == "0" ]]; then
        echo -n "^fg($DZEN_FG2)^ca(1,$DROP_START_CMD)DROPBOX^ca() ^fg()Off"
    else
        echo -n "^fg($DZEN_FG2)^ca(1,$DROP_STOP_CMD)DROPBOX^ca() ^fg($CRIT)On"
    fi
    return
}

printDateInfo() {
    echo -n "^ca(1,$CAL_CMD)^fg()$(date '+%Y^fg(#444).^fg()%m^fg(#444).^fg()%d^fg(#3955c4)/^fg(#444444)%a ^fg(#363636)| ^fg()%H^fg(#444):^fg()%M^fg(#444):^fg()%S')^ca() "
    return
}

printSpace() {
    echo -n " ^fg($COLOR_SEP)|^fg() "
    return
}

printLeft() {
    while true; do
        printVolInfo
        printSpace
        printDropBoxInfo
        echo -n " ^fg()>^fg($BAR_FG)>^fg($DZEN_FG2)>"
        echo
        sleep $INTERVAL
    done
    return
}

printRight() {
    while true; do
        printCPUInfo
        printSpace
        printMemInfo
        printSpace
        printTempInfo
        printSpace
        printDateInfo
        echo
        sleep $INTERVAL
    done
    return
}

#Print all and pipe into dzen
printLeft | dzen2 -x $X_POS_L -y $Y_POS -w $WIDTH_L -h $HEIGHT -fn $FONT -ta 'l' -bg $DZEN_BG -fg $DZEN_FG -p -e '' &
printRight | dzen2 -x $X_POS_R -y $Y_POS -w $WIDTH_R -h $HEIGHT -fn $FONT -ta 'r' -bg $DZEN_BG -fg $DZEN_FG -p -e ''
