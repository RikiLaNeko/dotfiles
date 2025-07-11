#!/bin/sh

# Config
THRESHOLD=20
EXTREME=5
STATE_FILE="/tmp/last_battery_level"

battery_level=$(cat /sys/class/power_supply/BAT1/capacity)
battery_status=$(cat /sys/class/power_supply/BAT1/status)

# Ne rien faire si branché
if [ "$battery_status" != "Discharging" ]; then
  exit 0
fi

# Dernier niveau alerté (par défaut: 100 pour forcer une alerte au début)
[ -f "$STATE_FILE" ] && last_level=$(cat "$STATE_FILE") || last_level=100

# Affiche seulement si nouveau palier est atteint
if [ "$battery_level" -lt "$EXTREME" ] && [ "$last_level" -ge "$EXTREME" ]; then
  notify-send -u critical -t 7000 "☠️ Batterie très faible" "Seulement ${battery_level}%. Branche MAINTENANT !"
  pw-play /usr/share/sounds/alert.wav 2>/dev/null
elif [ "$battery_level" -lt "$THRESHOLD" ] && [ "$last_level" -ge "$THRESHOLD" ]; then
  notify-send -u critical -t 7000 "⚡ Batterie faible" "Seulement ${battery_level}%. Branche vite !"
  pw-play /usr/share/sounds/alert.wav 2>/dev/null
fi

# Sauvegarde le niveau actuel pour la prochaine exécution
echo "$battery_level" >"$STATE_FILE"
