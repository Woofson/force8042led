#!/bin/bash

# Path to your flag file
RUN_FLAG="/tmp/led_notification_active"

start_pulse() {
    # If already running, don't start another one
    if [ -f "$RUN_FLAG" ]; then
        exit 0
    fi

    # Create the flag
    touch "$RUN_FLAG"

    # Start the loop
    (
        while [ -f "$RUN_FLAG" ]; do
            kbd_led_force 1
            # We check for the flag even during the sleep periods
            # by breaking the sleep into smaller chunks
            for i in {1..15}; do
                [ ! -f "$RUN_FLAG" ] && break 2
                sleep 0.1
            done

            kbd_led_force 0
            for i in {1..5}; do
                [ ! -f "$RUN_FLAG" ] && break 2
                sleep 0.1
            done
        done
        
        # Final cleanup ensures LED is off when the loop exits
        kbd_led_force 0
    ) &
}

stop_pulse() {
    # Removing the file causes the 'while' loop and 'sleep' loops to exit
    rm -f "$RUN_FLAG"
    # Wait a tiny bit for the loop to see the file is gone, then force off
    sleep 0.2
    kbd_led_force 0
}

case "$1" in
    start) start_pulse ;;
    stop)  stop_pulse  ;;
esac
