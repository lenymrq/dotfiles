#!/bin/sh

THEME_FILE="${XDG_CONFIG_HOME:-$HOME}/.theme"
if [ -f "$THEME_FILE" ]; then
    THEME="$(cat $THEME_FILE)"
else
    THEME='dark'
fi

if [ $THEME != 'dark' ] && [ $THEME != 'light' ]; then
    THEME='dark'
fi

echo THEME $THEME

FOOT_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/foot/foot.ini"
NWG_LOOK_CONFIG="${XDG_CONFIG_HOME:-$HOME/.local}/share/nwg-look/gsettings"

if [ $THEME = 'dark' ]; then
    sed -Ei 's/initial-color-theme=(light|dark)/initial-color-theme=dark/' "$FOOT_CONFIG"
    pkill -u "$USER" --signal=SIGUSR1 ^foot$

    sed -Ei 's/color-scheme=prefer-(light|dark)/color-scheme=prefer-dark/' "$NWG_LOOK_CONFIG"
    echo 'light' > ~/.theme
else
    sed -Ei 's/initial-color-theme=(light|dark)/initial-color-theme=light/' "$FOOT_CONFIG"
    pkill -u "$USER" --signal=SIGUSR2 ^foot$

    sed -Ei 's/color-scheme=prefer-(light|dark)/color-scheme=prefer-light/' "$NWG_LOOK_CONFIG"
    echo 'dark' > ~/.theme
fi

nwg-look -a
