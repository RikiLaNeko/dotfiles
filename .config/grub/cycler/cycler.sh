#!/usr/bin/env bash

# NixOS GRUB Theme Cycler
# Alterne entre différents thèmes GRUB au démarrage

set -euo pipefail

# Configuration
CONFIG_FILE="/etc/nixos/configuration.nix"
STATE_FILE="/var/lib/grub-theme-cycler/current_theme"
THEMES_BASE_PATH="/home/dedsec/dotfiles/.config/grub/themes"

# Liste des thèmes disponibles (relatifs au chemin de base)
THEMES=("bsol" "dedsec/WannaCry" "dedsec/Compact")

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Vérifier les permissions root
check_root() {
  if [[ $EUID -ne 0 ]]; then
    log_error "Ce script doit être exécuté en tant que root"
    exit 1
  fi
}

# Créer le dossier d'état si nécessaire
setup_state_dir() {
  local state_dir=$(dirname "$STATE_FILE")
  if [[ ! -d "$state_dir" ]]; then
    mkdir -p "$state_dir"
    log_info "Création du dossier d'état: $state_dir"
  fi
}

# Lire le thème actuel depuis la configuration NixOS
get_current_theme_from_config() {
  local current_theme_path=""

  # Debug: afficher la ligne trouvée
  log_info "Debug: recherche du thème dans $CONFIG_FILE"

  # Chercher dans la config NixOS (deux formats)
  if grep -q "boot\.loader\.grub\.theme.*=" "$CONFIG_FILE"; then
    # Format 1: boot.loader.grub.theme = "/path";
    if grep -q "boot\.loader\.grub\.theme = " "$CONFIG_FILE"; then
      current_theme_path=$(grep "boot\.loader\.grub\.theme = " "$CONFIG_FILE" | sed 's/.*"\(.*\)".*/\1/' | xargs)
      log_info "Debug: trouvé format 1: $current_theme_path"

    # Format 2: theme = "/path"; (dans un bloc)
    elif grep -q "theme = " "$CONFIG_FILE"; then
      current_theme_path=$(grep "theme = " "$CONFIG_FILE" | sed 's/.*"\(.*\)".*/\1/' | xargs)
      log_info "Debug: trouvé format 2: $current_theme_path"
    fi
  else
    log_info "Debug: aucun thème GRUB trouvé"
  fi

  # Extraire le nom du thème relatif
  if [[ -n "$current_theme_path" ]]; then
    log_info "Debug: chemin complet: $current_theme_path"

    # Supprimer le chemin de base et les slashes
    local theme_name="${current_theme_path#$THEMES_BASE_PATH/}"
    theme_name="${theme_name%/}" # supprimer slash final si présent

    log_info "Debug: nom du thème extrait: '$theme_name'"

    # Trouver l'index correspondant
    for i in "${!THEMES[@]}"; do
      local clean_theme="${THEMES[$i]%/}" # supprimer slash final si présent
      log_info "Debug: comparaison '$clean_theme' == '$theme_name'"
      if [[ "$clean_theme" == "$theme_name" ]]; then
        log_info "Debug: match trouvé à l'index $i"
        echo "$i"
        return 0
      fi
    done

    log_info "Debug: aucun match trouvé, utilisation de l'index 0"
  fi

  # Si pas trouvé, retourner l'index par défaut
  echo "0"
}

# Lire le thème actuel depuis le fichier d'état (ancien comportement)
get_current_theme_index_from_state() {
  if [[ -f "$STATE_FILE" ]]; then
    cat "$STATE_FILE"
  else
    echo "0"
  fi
}

# Calculer le prochain thème
get_next_theme_index() {
  local current_index=$(get_current_theme_index)
  local next_index=$(((current_index + 1) % ${#THEMES[@]}))
  echo "$next_index"
}

# Sauvegarder l'index du thème actuel
save_theme_index() {
  echo "$1" >"$STATE_FILE"
}

# Vérifier si le fichier de configuration existe
check_config_file() {
  if [[ ! -f "$CONFIG_FILE" ]]; then
    log_error "Fichier de configuration NixOS non trouvé: $CONFIG_FILE"
    exit 1
  fi
}

# Vérifier si les thèmes existent
check_themes() {
  for theme in "${THEMES[@]}"; do
    local theme_path="$THEMES_BASE_PATH/$theme"
    if [[ ! -d "$theme_path" ]]; then
      log_error "Thème non trouvé: $theme_path"
      exit 1
    fi

    # Vérifier que le thème a un fichier theme.txt
    if [[ ! -f "$theme_path/theme.txt" ]]; then
      log_warning "Le thème $theme n'a pas de fichier theme.txt"
    fi
  done
}

# Modifier la configuration NixOS
update_nixos_config() {
  local theme_index=$1
  local theme_name="${THEMES[$theme_index]}"
  local theme_path="$THEMES_BASE_PATH/$theme_name"

  log_info "Passage au thème: $theme_name"

  # NixOS gère ses propres sauvegardes via les générations
  log_info "Modification de la configuration (NixOS gère les sauvegardes automatiquement)"

  # Rechercher le pattern de thème GRUB (deux formats possibles)
  if grep -q "boot\.loader\.grub\.theme.*=" "$CONFIG_FILE"; then
    # Échapper le chemin pour sed
    local escaped_path=$(echo "$theme_path" | sed 's/[[\.*^$()+?{|]/\\&/g')

    # Format 1: boot.loader.grub.theme = "/path";
    if grep -q "boot\.loader\.grub\.theme = " "$CONFIG_FILE"; then
      sed -i "s|boot\.loader\.grub\.theme = .*|boot.loader.grub.theme = \"$theme_path\";|g" "$CONFIG_FILE"
      log_success "Configuration mise à jour (format simple) avec le thème: $theme_name"

    # Format 2: theme = "/path"; (dans un bloc boot.loader.grub)
    elif grep -q "theme = " "$CONFIG_FILE"; then
      # Plus précis: recherche "theme =" avec des espaces ou tabulations avant
      sed -i "s|^[[:space:]]*theme = .*|  theme = \"$theme_path\";|g" "$CONFIG_FILE"
      log_success "Configuration mise à jour (format bloc) avec le thème: $theme_name"
    fi

  else
    log_error "Configuration boot.loader.grub.theme non trouvée dans $CONFIG_FILE"
    log_info "Formats supportés:"
    log_info "  Format 1: boot.loader.grub.theme = \"/path\";"
    log_info "  Format 2: boot.loader.grub = { theme = \"/path\"; };"
    log_info ""
    log_info "Votre configuration devrait ressembler à:"
    log_info "  boot.loader.grub = {"
    log_info "    enable = true;"
    log_info "    theme = \"$theme_path\";"
    log_info "    # autres options..."
    log_info "  };"
    exit 1
  fi
}

# Trouver nixos-rebuild
find_nixos_rebuild() {
  local nixos_rebuild_path

  # Essayer les emplacements habituels
  for path in "/run/current-system/sw/bin/nixos-rebuild" \
    "/nix/var/nix/profiles/system/sw/bin/nixos-rebuild" \
    "$(which nixos-rebuild 2>/dev/null)" \
    "/usr/bin/nixos-rebuild"; do
    if [[ -x "$path" ]]; then
      nixos_rebuild_path="$path"
      break
    fi
  done

  if [[ -z "$nixos_rebuild_path" ]]; then
    log_error "nixos-rebuild non trouvé"
    log_info "Chemins testés:"
    log_info "  /run/current-system/sw/bin/nixos-rebuild"
    log_info "  /nix/var/nix/profiles/system/sw/bin/nixos-rebuild"
    log_info "Essayez de définir la variable PATH ou utilisez le chemin complet"
    exit 1
  fi

  echo "$nixos_rebuild_path"
}

# Reconstruire le système NixOS
rebuild_system() {
  log_info "Reconstruction du système NixOS..."

  local nixos_rebuild=$(find_nixos_rebuild)
  log_info "Utilisation de nixos-rebuild: $nixos_rebuild"

  if "$nixos_rebuild" switch; then
    log_success "Système reconstruit avec succès"
  else
    log_error "Échec de la reconstruction du système"
    log_info "Vous pouvez restaurer la génération précédente avec:"
    log_info "  sudo nixos-rebuild switch --rollback"
    exit 1
  fi
}

# Fonction principale
main() {
  log_info "=== NixOS GRUB Theme Cycler ==="

  check_root
  setup_state_dir
  check_config_file
  check_themes

  # Obtenir les index actuels et suivants
  # Priorité: fichier d'état (si on vient de faire un changement) puis config NixOS
  local state_index=$(get_current_theme_index_from_state)
  local config_index=$(get_current_theme_from_config)

  # Si le fichier d'état existe et est différent de la config, utiliser l'état
  # (ça veut dire qu'on vient de faire un changement)
  local current_index
  if [[ -f "$STATE_FILE" ]] && [[ "$state_index" != "$config_index" ]]; then
    current_index="$state_index"
    log_info "Utilisation de l'état sauvegardé (changement récent)"
  else
    current_index="$config_index"
    log_info "Lecture depuis la configuration NixOS"
  fi

  local next_index=$(((current_index + 1) % ${#THEMES[@]}))
  local current_theme="${THEMES[$current_index]}"
  local next_theme="${THEMES[$next_index]}"

  log_info "Thèmes disponibles: ${THEMES[*]}"
  log_info "Thème actuel: $current_theme"
  log_info "Prochain thème: $next_theme"

  # Demander confirmation en mode interactif
  if [[ "${1:-}" != "--auto" ]]; then
    read -p "Passer de '$current_theme' vers '$next_theme' ? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      log_info "Opération annulée"
      exit 0
    fi
  fi

  # Sauvegarder le nouvel index AVANT la modification (pour éviter les incohérences)
  save_theme_index "$next_index"

  # Mettre à jour la configuration
  update_nixos_config "$next_index"

  # Reconstruire le système
  rebuild_system

  log_success "Thème GRUB changé vers: $next_theme"
  log_info "Le nouveau thème sera visible au prochain redémarrage"
}

# Fonction pour afficher l'aide
show_help() {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --auto    Exécution automatique sans confirmation"
  echo "  --help    Afficher cette aide"
  echo ""
  echo "Ce script alterne entre les thèmes GRUB configurés:"
  for i in "${!THEMES[@]}"; do
    echo "  [$i] ${THEMES[$i]}"
  done
}

# Gérer les arguments
case "${1:-}" in
--help)
  show_help
  exit 0
  ;;
*)
  main "$@"
  ;;
esac
