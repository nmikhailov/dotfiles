#!/bin/bash
source ~/.xmonad/bin/settings.sh
# Layout
WIDTH=$(echo "$SCREEN_WIDTH - $BOTTOM_LEFT_WIDTH" | bc)
Y_POS=$(echo "$SCREEN_HEIGHT - $HEIGHT" | bc)

#Options
INTERVAL=5
WIFISIGNAL=0

printDiskInfo() {
    RFSP=$(df -h / | tail -1 | awk '{ print $5 }' | tr -d '%')
    HFSP=$(df -h /home | tail -1 | awk '{ print $5 }' | tr -d '%')
    echo -n "^fg($DZEN_FG2)ROOT ^fg($BAR_FG)${RFSP}% "
    echo -n "^fg($DZEN_FG2)HOME ^fg($BAR_FG)${HFSP}%"
    return
}

printBattery() {
    BatPresent=$(acpi -b | wc -l)
    ACPresent=$(acpi -a | grep -c on-line)
    if [[ $BatPresent == "0" ]]; then
        echo -n "^fg($DZEN_FG2)AC ^fg($BAR_FG)on ^fg($DZEN_FG2)BAT ^fg($BAR_FG)off"
        return
    else
        RPERC=$(acpi -b | awk '{print $4}' | tr -d "%,")
        echo -n "^fg($DZEN_FG2)BAT "
        if [[ $ACPresent == "1" ]]; then
            echo -n " ^fg($BAR_FG)$RPERC%"
        else
            echo -n " ^fg($CRIT)$RPERC%"
       fi
    fi
    return
}

printBrightnessInfo() {
    BRIFILE=$(cat /sys/class/backlight/acpi_video0/actual_brightness)
    Bri=$(expr $BRIFILE \* 10)
    echo -n "^fg($DZEN_FG2)BRI ^fg($BAR_FG)${Bri}%"
    return
}

printWifiInfo() {
    WIFIDOWN=$(wicd-cli --wireless -d | wc -l)
    WIFISIGNAL=0
#   [[ $WIFIDOWN -ne "1" ]] && WIFISIGNAL=$(wicd-cli --wireless -d | grep Quality | awk '{print $2}')
    echo -n "^fg($DZEN_FG2)WIFI "
    if [[ $WIFIDOWN -ne "1" ]]; then
        WIFISIGNAL=$(wicd-cli --wireless -d | grep Quality | awk '{print $2}')
#        echo -n "$(echo $WIFISIGNAL | gdbar -fg $BAR_FG -bg $BAR_BG -h $BAR_H -w $BIGBAR_W -s o -ss 1 -sw 2 -nonl) "
        echo -n "^fg($BAR_FG)$WIFISIGNAL%"
    else
        echo -n "^fg($CRIT)N/A "
    fi
    return
}

printLanInfo() {
    LAN=$(ip addr show eth0 | grep "inet " | wc -l)
    echo -n "^fg($DZEN_FG2)LAN "
    if [[ $LAN -ne 1 ]]; then
        echo -n "^fg($CRIT)N/A"
    else
        echo -n "^fg($BAR_FG)OK "
    fi
}

printVideoInfo() {
    VgaSwitcheroo="/sys/kernel/debug/vgaswitcheroo/switch"

    echo -n "^fg($DZEN_FG2)GPU "

    if [ -e $VgaSwitcheroo ]
    then
        Val=$(cat $VgaSwitcheroo | grep -v -i "audio")

        OnCount=$(echo $Val | grep -ic "pwr")
        VCard=$(echo $Val | grep "+" | sed -r "s/[0-9]+\://" | sed -r "s/\:.*//")

        if [[ $OnCount -ne 1 ]]; then
            echo -n "^fg($CRIT)"
        else
            echo -n "^fg($BAR_FG)"
        fi
        echo -n "$VCard"
    else
        echo -n "^fg($BAR_FG)CAT"
    fi
}

printSpace() {
    echo -n " ^fg($COLOR_SEP)|^fg() "
    return
}

printBottomBar() {
    while true; do
        printVideoInfo
        printSpace
        printDiskInfo
        printSpace
        printBattery
        printSpace
#        printBrightnessInfo
#        printSpace
        printWifiInfo
        printSpace
        printLanInfo
        echo
        sleep $INTERVAL
    done
    return
}

#Print all and pipe into dzen2
printBottomBar | dzen2 -x $BOTTOM_LEFT_WIDTH -y $Y_POS -w $WIDTH -h $HEIGHT -fn $FONT -ta 'r' -bg $DZEN_BG -fg $DZEN_FG -p -e ''
