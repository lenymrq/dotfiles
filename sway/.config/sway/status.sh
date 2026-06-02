#!/bin/sh

printf '{"version":1}\n'
printf '[\n'

while true; do
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
    DATE=$(date +'%Y-%m-%d')
    TIME=$(date +'%X')

    printf '['
    printf '{"full_text":"%s %s%%"},' $BATTERY_STATUS $BATTERY_CAPACITY
    printf '{"full_text":"%s %s"}' $TIME $DATE
    printf '],\n'

    sleep 1
done

