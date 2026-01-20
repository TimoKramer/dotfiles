#!/bin/bash

# Get connected outputs, excluding the built-in display (eDP-*)
external_count=$(niri msg --json outputs | jq '[to_entries[] | select(.key | startswith("eDP") | not)] | length')

if [ "$external_count" -eq 0 ]; then
    niri msg action power-off-monitors
fi
