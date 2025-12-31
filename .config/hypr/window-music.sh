#!/bin/bash

MUSIC="/home/geocube/Music-autostart/Buttercup.mp3"
PLAYER="mpv --no-video --loop --quiet \"$MUSIC\""

while true; do
    # Count windows
    WINCOUNT=$(hyprctl clients -j | jq length)

    if [ "$WINCOUNT" -eq 0 ]; then
        # If no windows AND mpv is not already running → play
        if ! pgrep -x mpv > /dev/null; then
            eval $PLAYER &
        fi
    else
        # If windows open → kill mpv
        if pgrep -x mpv > /dev/null; then
            pkill -x mpv
        fi
    fi

    sleep 1
done

