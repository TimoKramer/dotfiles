#!/bin/env bash

echo 'lid-close.sh' | systemd-cat -p info

niri msg action switch-layout 0 && gtklock && systemctl suspend
