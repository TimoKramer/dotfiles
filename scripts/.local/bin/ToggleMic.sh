#!/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

DEFAULT=$(pactl get-default-source)
AUNA=$(pactl list short sources | grep Auna | awk '{print $2}')
if [[ -n $AUNA ]]; then
    pactl set-default-source $AUNA
    pactl set-source-mute $AUNA toggle
else
    pactl set-source-mute $DEFAULT toggle
    amixer set Capture toggle && amixer get Capture | grep "\[off\]" && notify-send "MIC switched OFF" || notify-send "MIC switched ON"
fi

NEW_DEFAULT=$(pactl get-default-source)
NEW_DEFAULT_MSG=$(echo ${NEW_DEFAULT} | cut -d - -f 2 | cut -c1-8)
MUTE_STATE=$(pactl get-source-mute $NEW_DEFAULT)
if [[ $MUTE_STATE == 'Mute: yes' ]]; then
    notify-send "${NEW_DEFAULT_MSG} switched OFF"
else
    notify-send "${NEW_DEFAULT_MSG} switched ON"
fi
