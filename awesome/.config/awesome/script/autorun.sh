killall nm-applet; nm-applet &
killall blueman-applet; blueman-applet &
killall picom; picom &
killall unclutter; unclutter --timeout 0.75 &
xss-lock --transfer-sleep-lock -- $(dirname "$0")/lock.sh &