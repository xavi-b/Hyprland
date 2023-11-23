#!/bin/bash
while true; do
    bat_lvl=0
    count=0
    for f in /sys/class/power_supply/BAT*; do
        cap=$(cat $f/capacity)
        bat_lvl=$(($bat_lvl + $cap))
        count=$(($count + 1))
    done
    if [ $count -eq 0 ]; then
        exit 0
    fi
    bat_lvl=$(($bat_lvl / $count))
    echo $bat_lvl
    if [ "$bat_lvl" -le 15 ]; then
        notify-send --urgency=CRITICAL "Battery Low" "Level: ${bat_lvl}%"
    fi
    sleep 300
done
