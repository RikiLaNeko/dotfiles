# Exlixir
phonix() {
  if [ -z "$1" ]; then
    echo "Usage : phonix <nom_du_projet>"
    return 1
  fi

  local project="$1"

  # Détection de l'OS
  detect_os() {
    if [ "$(uname)" = "Darwin" ]; then
      echo "macos"
    elif [ -f "/etc/debian_version" ]; then
      echo "debian"
    elif [ -f "/etc/arch-release" ]; then
      echo "arch"
    else
      echo "unknown"
    fi
  }

  # Vérifie si une commande existe
  ensure_cmd() {
    if ! command -v "$1" &>/dev/null; then
      echo "$1 non trouvé, installation..."
      return 1
    fi
    return 0
  }

  # Installation dépendances
  setup_env() {
    local os=$(detect_os)

    case "$os" in
      macos)
        ensure_cmd brew || return 1
        brew install elixir
        ;;
      debian)
        sudo apt update
        sudo apt install -y curl gnupg elixir erlang-dev erlang-parsetools inotify-tools
        ;;
      arch)
        sudo pacman -Sy --noconfirm elixir erlang base-devel inotify-tools
        ;;
      *)
        echo "OS non supporté automatiquement. Installe Elixir manuellement."
        return 1
        ;;
    esac

    mix local.hex --force
    mix archive.install hex phx_new --force
  }

  # Vérification de l’environnement
  if ! command -v elixir &>/dev/null || ! command -v mix &>/dev/null; then
    echo "Elixir ou Mix non installés. Lancement de l'installation..."
    setup_env || return 1
  fi

  # Vérifie si dossier existe déjà
  if [ -f "$project/mix.exs" ] && grep -q phoenix "$project/mix.exs"; then
    echo "Projet Phoenix détecté dans '$project'. Démarrage..."
    cd "$project" || return
    iex -S mix phx.server
  else
    read -p "Quelle base de données ? (default: sqlite3) " db
    db=${db:-sqlite3}

    echo "Création du projet '$project' avec la base de données : $db"
    mix phx.new "$project" --database "$db" --no-install
    cd "$project" || return
    mix deps.get
    mix ecto.create
    iex -S mix phx.server
  fi
}

# 🧠 Utilitaires divers
please() {
  local cmd=$(fc -ln -1)
  case "$cmd" in
    cd*|source*|alias*|export*|please*)
      echo "⛔️ Commande non éligible à please : '$cmd'"
      ;;
    *)
      eval sudo "$cmd"
      ;;
  esac
}

# Fonction nvim avec fallback fzf
nvim() {
  if [ "$#" -eq 0 ]; then
    local file
    file=$(fzf --preview 'bat --style=numbers --color=always --line-range :100 {}' 2> /dev/null)
    if [[ -n "$file" ]]; then
      command nvim "$file"
    else
      echo "❌ Aucun fichier sélectionné."
    fi
  else
    command nvim "$@"
  fi
}

# show: Extraire une colonne de la sortie d'une commande par son nom.
show() {
  if [ -t 0 ] || [ -z "$1" ]; then
    echo "Utilisation: <commande> | show <NOM_DE_LA_COLONNE>" >&2
    return 1
  fi

  local column_name="$1"

  awk -v col_name="$column_name" '
    NR==1 {
      for(i=1; i<=NF; i++) {
        if($i == col_name) {
          col_idx = i;
          break;
        }
      }
      if(col_idx) {
        print $col_idx;
      } else {
        print "Erreur: Colonne '" col_name "' non trouvée." > "/dev/stderr";
        print "Colonnes disponibles: " $0 > "/dev/stderr";
        exit 1;
      }
    }
    NR>1 {
      if(col_idx) {
        print $col_idx;
      }
    }
  '
}

# cols: Formate la sortie en colonnes alignées.
cols() {
  if [ -t 0 ]; then
    echo "Utilisation: <commande> | cols" >&2
    return 1
  fi
  column -t
}

# num: Ajoute un numéro de ligne (ID) à la sortie.
# Numérote chaque ligne de la sortie, en ignorant la ligne d'en-tête.
#
# UTILISATION :
#   <commande> | num
num() {
  if [ -t 0 ]; then
    echo "Utilisation: <commande> | num" >&2
    return 1
  fi
  
  # Imprime l'en-tête, puis numérote les lignes suivantes avec un formatage.
  awk 'NR==1 {print} NR>1 {printf "%-4d %s\n", NR-1, $0}'
}

# dcr: Gérer ou créer des conteneurs Docker de manière interactive.
dcr() {
  # Mode 1: Gestion interactive si aucun argument n'est fourni
  if [ "$#" -eq 0 ]; then
    local container_info
    container_info=$(docker ps -a --format "{{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}" | fzf --header "Select a container" --preview 'docker inspect {1}' --height 40% --layout=reverse)

    if [ -z "$container_info" ]; then
      echo "❌ Aucune sélection."
      return 1
    fi

    local container_id=$(echo "$container_info" | awk '{print $1}')
    local container_name=$(echo "$container_info" | awk '{print $3}')

    echo "Que faire avec le conteneur $container_name ($container_id) ?"
    local actions=("exec (shell)" "logs" "stop" "start" "rm" "inspect" "quit")
    local action
    select action in "${actions[@]}"; do
      case "$action" in
        "exec (shell)")
          docker exec -it "$container_id" /bin/bash
          break
          ;;
        "logs")
          docker logs -f "$container_id"
          break
          ;;
        "stop")
          docker stop "$container_id"
          break
          ;;
        "start")
          docker start "$container_id"
          break
          ;;
        "rm")
          read "confirm?Êtes-vous sûr de vouloir supprimer le conteneur $container_name? (y/N) "
          if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
            docker rm "$container_id"
          else
            echo "Suppression annulée."
          fi
          break
          ;;
        "inspect")
          docker inspect "$container_id" | bat
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
  # Mode 2: Création rapide avec sélection d'image
  else
    local image_query="$1"
    local selected_image
    selected_image=$(docker search "$image_query" --format "{{.Name}}" | fzf --header "Select an image for interactive session" --height 40% --layout=reverse)

    if [ -z "$selected_image" ]; then
      echo "❌ Aucune image sélectionnée."
      return 1
    fi

    echo "Image sélectionnée : $selected_image"

    local container_name
    local ports

    read "container_name?Nom du conteneur (optionnel, Entrée pour auto) : "
    read "ports?Mapper les ports (ex: 8080:80, optionnel) : "

    local run_cmd="docker run -it"
    if [ -n "$container_name" ]; then
      run_cmd="$run_cmd --name $container_name"
    fi
    if [ -n "$ports" ]; then
      run_cmd="$run_cmd -p $ports"
    fi

    run_cmd="$run_cmd $selected_image"

    echo "Commande exécutée : $run_cmd"
    eval "$run_cmd"
  fi
}

# dcc: Créer et démarrer un conteneur Docker en mode détaché (-d).
dcc() {
  local selected_image

  # Si aucun argument, lister les images locales. Sinon, chercher sur Docker Hub.
  if [ "$#" -eq 0 ]; then
    selected_image=$(docker images --format "{{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.Size}}" | fzf --header "Select a local image to run detached" --preview 'docker image inspect {2}' --height 40% --layout=reverse | awk '{print $1}')
  else
    local image_query="$1"
    selected_image=$(docker search "$image_query" --format "{{.Name}}" | fzf --header "Select an image to run detached" --height 40% --layout=reverse)
  fi

  # Si aucune image n'est sélectionnée (l'utilisateur a quitté fzf), on arrête.
  if [ -z "$selected_image" ]; then
    echo "❌ Aucune image sélectionnée."
    return 1
  fi

  echo "Image sélectionnée : $selected_image"

  # Logique de création commune
  local container_name
  local ports

  read "container_name?Nom du conteneur (optionnel, Entrée pour auto) : "
  read "ports?Mapper les ports (ex: 6379:6379, optionnel) : "

  local run_cmd="docker run -d"
  if [ -n "$container_name" ]; then
    run_cmd="$run_cmd --name $container_name"
  fi
  if [ -n "$ports" ]; then
    run_cmd="$run_cmd -p $ports"
  fi

  run_cmd="$run_cmd $selected_image"

  echo "Lancement de la commande : $run_cmd"
  local container_id
  container_id=$(eval "$run_cmd")
  
  if [ $? -eq 0 ]; then
    echo "✅ Conteneur démarré en mode détaché."
    echo "   ID court: $(echo "$container_id" | cut -c1-12)"
  else
    echo "❌ Erreur lors du démarrage du conteneur."
  fi
}