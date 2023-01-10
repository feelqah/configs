#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/colorblocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
#polybar -q main -c "$DIR"/config.ini &


for m in $(polybar --list-monitors | cut -d":" -f1); do
    tray_pos="none" 

    echo "test: $m"                                    
    if [ "$m" == "eDP-1" ]; then
        tray_pos="right"
    fi 
    MONITOR=$m TRAY_POS=$tray_pos polybar -q main -c "$DIR"/config.ini  2>&1 | tee -a /tmp/polybar.log & disown
done
