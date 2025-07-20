#!/usr/bin/env bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/src/mocha/style.css"
PROMPT="Recherche le JaaJ"

if [[ ! $(pidof wofi) ]]; then
  wofi --conf "${CONFIG}" --style "${STYLE}" --insensitive --prompt "${PROMPT}" --show drun &
else
  pkill wofi
fi
