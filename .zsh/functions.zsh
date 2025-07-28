# === Fonctions personnalisées ===

# Ouvre une URL dans le navigateur
open_command() {
  if command -v xdg-open >/dev/null; then
    xdg-open "$1" >/dev/null 2>&1 &
  else
    echo "No suitable open command found." >&2
  fi
}

# Recherche un paquet sur search.nixos.org
nixpkgs() {
  local q="${*// /%20}"
  xdg-open "https://search.nixos.org/packages?channel=25.05&from=0&size=50&sort=relevance&type=packages&query=${q}" >/dev/null 2>&1 &
}

# Recherche sur le wiki NixOS
nixwiki() {
  local q="${*// /+}"
  xdg-open "https://nixos.wiki/index.php?search=${q}&go=Go" >/dev/null 2>&1 &
}

