#!/usr/bin/sh

killall nm-applet; nm-applet &
killall blueman-applet; blueman-applet &
killall picom; picom &
killall unclutter; unclutter --timeout 0.75
xss-lock --transfer-sleep-lock -- i3lock -i ~/.local/share/backgrounds/frieren-2.png &
