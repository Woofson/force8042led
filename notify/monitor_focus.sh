#!/bin/bash

# Give Hyprland a moment to create the socket if this runs at boot
sleep 2

# Construct the socket path
HYPR_SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Safety check: Is the socket there?
if [ ! -S "$HYPR_SOCKET" ]; then
    echo "Error: Hyprland socket2 not found at $HYPR_SOCKET"
    exit 1
fi

# Connect and listen
socat -U - UNIX-CONNECT:"$HYPR_SOCKET" | while read -r line; do
    if [[ "$line" == "activewindow>>"* ]]; then
        # Extract the window class
        WINDOW_INFO="${line#*>>}"
        CLASS="${WINDOW_INFO%%,*}"

        # Match your apps
        if [[ "$CLASS" =~ (telegram|discord) ]]; then
            ~/.config/hypr/scripts/led_notify.sh stop
        fi
    fi
done
