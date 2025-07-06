#!/usr/bin/env bash

<<<<<<< HEAD
wofi \
  --conf "$HOME/.config/wofi/config" \
  --style "$HOME/.config/wofi/src/mocha/style.css" \
  --show drun
=======
CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/src/mocha/style.css"

if [[ ! $(pidof wofi) ]]; then
  wofi --conf "${CONFIG}" --style "${STYLE}" --show drun &
else
  pkill wofi
fi
>>>>>>> 17994da (Added in wofi)
