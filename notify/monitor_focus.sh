## needs socat and jq installed.

#!/bin/bash
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    if [[ "$line" == activewindow* ]]; then
        # Use jq to pull the class of the newly focused window
        CLASS=$(hyprctl activewindow -j | jq -r '.class')
        
        if [[ "$CLASS" == "org.telegram.desktop" || "$CLASS" == "discord" ]]; then
            ~/.config/hypr/scripts/led_notify.sh stop
        fi
    fi
done
