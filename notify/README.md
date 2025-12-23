# Notifications on CapsLock LED


I use these scripts in Hyprland with Mako to flash my leds when I get notifications from certain apps, instead of onscreen.  

## Copy these files to ~/.config/hypr/scripts/

### Add to mako config:
[app-name="Telegram Desktop"]
on-notify=exec ~/.config/hypr/scripts/led_notify.sh start

[app-name="Discord"]
on-notify=exec ~/.config/hypr/scripts/led_notify.sh start

### To Hyprland.conf

exec-once = ~/.config/hypr/scripts/monitor_focus.sh
