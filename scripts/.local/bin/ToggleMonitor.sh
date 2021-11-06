#!/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

intern=eDP1
extern=DP3

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --off --output "$extern" --auto
fi
