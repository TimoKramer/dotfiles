#!/bin/bash

RESULT=$(curl https://am.i.mullvad.net/json 2> /dev/null)

if [[ true == $(echo ${RESULT} | jq '.mullvad_exit_ip') ]]; then
    if [[ false == $(echo ${RESULT} | jq '.blacklisted.blacklisted') ]]; then
	echo "Connected"
    else
	echo "Connected|Blacklisted"
    fi
else
	echo "Not connected"
fi
