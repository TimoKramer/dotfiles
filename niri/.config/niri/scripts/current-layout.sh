#!/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

niri msg keyboard-layouts | /bin/grep '\*' | /bin/cut -d' ' -f4 | /bin/cut -c1-2
