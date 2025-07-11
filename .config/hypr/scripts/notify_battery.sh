#!/bin/sh

# Config
THRESHOLD=15
EXTREME=5
battery_level=$(cat /sys/class/power_supply/BAT1/capacity)

# Choix du message
if [ "$battery_level" -lt "$EXTREME" ]; then
  notify-send -u critical -t 10000 "☠️ Batterie très faible" "Seulement ${battery_level}%. Branche MAINTENANT !"
  pw-play /usr/share/sounds/alert.wav 2>/dev/null
elif [ "$battery_level" -lt "$THRESHOLD" ]; then
  notify-send -u critical -t 10000 "⚡ Batterie faible" "Seulement ${battery_level}%. Branche vite !"
  pw-play /usr/share/sounds/alert.wav 2>/dev/null
fi
