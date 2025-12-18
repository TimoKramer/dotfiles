#!/bin/bash

# Enable all outputs that exist
niri msg -j outputs | jq -r 'keys[]' | while read -r output; do
    echo "activating ${output}"
    niri msg output "$output" on
done
