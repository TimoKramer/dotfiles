#!/bin/bash
# triggered by udev rule /etc/udev/rules.d/95-hdmi-plug.rules
# https://wiki.archlinux.org/title/Udev#Execute_when_HDMI_cable_is_plugged_in_or_unplugged

export SWAYSOCK="/run/user/$(id -u)/sway-ipc.$(pgrep -x sway).sock"

sleep 1

# Enable all outputs that exist
swaymsg -t get_outputs | grep -oP '"name":\s*"\K[^"]+' | while read -r output; do
    swaymsg output "$output" enable
done
