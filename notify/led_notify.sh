#!/bin/bash

PID_FILE="/tmp/led_notify_pid"

# A slow, calm "pulse" using only ON/OFF states
# 1.5s On, 0.5s Off, 1s Pause
calm_rhythm() {
    kbd_led_force 1
    sleep 1.5
    kbd_led_force 0
    sleep 0.5
    # Total cycle is 2 seconds
}

start_pulse() {
    # If already running, don't start another process
    if [ -f "$PID_FILE" ]; then exit 0; fi

    (
        while true; do
            calm_rhythm
        done
    ) &
    echo $! > "$PID_FILE"
}

stop_pulse() {
    if [ -f "$PID_FILE" ]; then
        # Kill the background loop
        pkill -P $(cat "$PID_FILE") 2>/dev/null
        kill $(cat "$PID_FILE") 2>/dev/null
        rm "$PID_FILE"
    fi
    # Ensure it's off
    kbd_led_force 0
}

case "$1" in
    start) start_pulse ;;
    stop)  stop_pulse ;;
esac
