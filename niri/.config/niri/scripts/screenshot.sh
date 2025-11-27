#!/usr/bin/env bash

set -o noclobber
set -o errexit
set -o pipefail
set -o nounset

function show_help() {
	cat <<-EOF
	Usage: $0 [--window] [--screen] [--region]
	This is a screenshot tool.
		--window to capture the whole window
		--screen to capture the whole screen
		--region to capture region
		--help   to show this help
	EOF
}

while [[ $# -gt 0 ]]; do
	case $1 in
		--window)
			niri msg action screenshot-window ; wl-paste --type image/png | satty -f -
			exit
			;;
		--screen)
			niri msg action screenshot-screen ; wl-paste --type image/png | satty -f -
			exit
			;;
		--region)
			niri msg action screenshot ; wl-paste --type image/png | satty -f -
			exit
			;;
		--help)
			show_help
			exit
			;;
		*)
			show_help
			exit
			;;
	esac
done
