# nixm: Gestionnaire interactif pour NixOS.
nixm() {
  echo "Assistant de gestion NixOS."
  echo "Choisissez une action :"

  local actions=(
    "Rechercher des paquets (nix search)"
    "Gérer les générations (nixos-rebuild)"
    "Nettoyer le store (nix-collect-garbage)"
    "Éditer la configuration (nvim /etc/nixos/configuration.nix)"
    "Voir les logs système (journalctl)"
    "Appliquer la configuration (nixos-rebuild switch)"
    "Annuler la dernière configuration (nixos-rebuild rollback)"
    "quit"
  )
  local action
  select action in "${actions[@]}"; do
    case "$action" in
      "Rechercher des paquets (nix search)")
        read "query?Terme de recherche : "
        if [ -n "$query" ]; then
          nix search nixpkgs "$query" | fzf --header "Nix Packages" --preview 'nix search nixpkgs {1} --json | jq -r '.[].description''
        fi
        break
        ;;
      "Gérer les générations (nixos-rebuild)")
        echo "Générations NixOS :"
        nixos-rebuild switch --list-generations | fzf --header "NixOS Generations" --preview 'nixos-rebuild switch --show-trace --flake .#$(hostname) --rollback-to {1}'
        read "gen_action?Action (rollback <num> / delete <num> / quit) : "
        if [[ "$gen_action" =~ ^rollback[[:space:]]+([0-9]+)$ ]]; then
          sudo nixos-rebuild switch --rollback-to "${BASH_REMATCH[1]}"
        elif [[ "$gen_action" =~ ^delete[[:space:]]+([0-9]+)$ ]]; then
          sudo nix-env --delete-generations "${BASH_REMATCH[1]}"
        fi
        break
        ;;
      "Nettoyer le store (nix-collect-garbage)")
        read "confirm?Êtes-vous sûr de vouloir nettoyer le store Nix ? (y/N) "
        if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
          sudo nix-collect-garbage -d
        else
          echo "Nettoyage annulé."
        fi
        break
        ;;
      "Éditer la configuration (nvim /etc/nixos/configuration.nix)")
        sudo nvim /etc/nixos/configuration.nix
        break
        ;;
      "Voir les logs système (journalctl)")
        echo "Logs système :"
        local log_actions=("Erreurs (journalctl -b -p err)" "Tous les logs (journalctl -f)" "quit")
        local log_action
        select log_action in "${log_actions[@]}"; do
          case "$log_action" in
            "Erreurs (journalctl -b -p err)")
              journalctl -b -p err | bat
              break
              ;;
            "Tous les logs (journalctl -f)")
              journalctl -f
              break
              ;;
            "quit")
              break
              ;;
            *)
              echo "Option invalide."
              ;;
          esac
        done
        break
        ;;
      "Appliquer la configuration (nixos-rebuild switch)")
        read "confirm?Êtes-vous sûr de vouloir appliquer la configuration NixOS ? (y/N) "
        if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
          sudo nixos-rebuild switch
        else
          echo "Application annulée."
        fi
        break
        ;;
      "Annuler la dernière configuration (nixos-rebuild rollback)")
        read "confirm?Êtes-vous sûr de vouloir annuler la dernière configuration NixOS ? (y/N) "
        if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
          sudo nixos-rebuild rollback
        else
          echo "Annulation annulée."
        fi
        break
        ;;
      "quit")
        break
        ;;
      *)
        echo "Option invalide."
        break
        ;;
    esac
  done
}
