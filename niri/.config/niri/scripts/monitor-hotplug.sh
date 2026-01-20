#!/bin/bash
# triggered by udev rule /etc/udev/rules.d/95-monitor-hotplug.rules
# https://wiki.archlinux.org/title/Udev#Execute_when_HDMI_cable_is_plugged_in_or_unplugged

# Enable all outputs that exist
niri msg -j outputs | jq -r 'keys[]' | while read -r output; do
    echo "activating display ${output}" | systemd-cat -p info -t monitor-hotplug
    niri msg output "$output" on
done
