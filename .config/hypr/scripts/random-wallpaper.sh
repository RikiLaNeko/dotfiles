#!/usr/bin/env bash

WALLPAPERS_DIR="$HOME/.wallpapers"
LAST_WALLPAPER_FILE="/tmp/last_wallpaper.txt"

# Récupère tous les fichiers avec extensions d’image
mapfile -t WALLPAPERS < <(fd . "$WALLPAPERS_DIR" -e jpg -e png -e jpeg)

# Vérifie qu'on a des fichiers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
  notify-send -t 3000 "⚠️ Aucun wallpaper trouvé"
  exit 1
fi

# Récupère le dernier utilisé (en 1 ligne seulement)
LAST="$(head -n 1 "$LAST_WALLPAPER_FILE" 2>/dev/null || echo "")"

# Choisit un nouveau fichier, différent du précédent
ATTEMPT=0
MAX_ATTEMPTS=10
NEW="$LAST"

while [[ "$NEW" == "$LAST" && $ATTEMPT -lt $MAX_ATTEMPTS ]]; do
  NEW=$(printf "%s\n" "${WALLPAPERS[@]}" | shuf -n 1)
  ATTEMPT=$((ATTEMPT + 1))
done

# Debug
echo "Dernier wallpaper : $LAST"
echo "Nouveau wallpaper : $NEW"

# Applique si trouvé
if [[ -f "$NEW" ]]; then
  swww img "$NEW" --transition-type grow --transition-duration 2
  echo "$NEW" >"$LAST_WALLPAPER_FILE"
  notify-send -t 3000 "🌄 Wallpaper changé" "$(basename "$NEW")"
else
  notify-send -t 3000 "❌ Wallpaper introuvable"
fi
