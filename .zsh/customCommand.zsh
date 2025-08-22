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

# Commande gin: Gère les projets Go avec Gin.
# - Si exécutée dans un dossier avec un go.mod, lance le projet avec '''air'''.
# - Sinon, crée un nouveau projet Gin avec une structure de base.
# Usage:
#   gin -> Lance le serveur de développement (si dans un projet).
#   gin <nom_du_projet> -> Crée un nouveau projet.
gin() {
    # Vérifie si Go est installé
    if ! command -v go &> /dev/null; then
        echo "❌ Go n'''est pas installé. Veuillez l'''installer pour continuer."
        return 1
    fi

    # Si un fichier go.mod existe, on est dans un projet Go.
    if [ -f "go.mod" ]; then
        echo "🚀 Projet Go détecté. Lancement avec air..."
        # Vérifie si air est installé, sinon l'''installe
        if ! command -v air &> /dev/null; then
            echo "💨 air n'''est pas trouvé. Installation de air..."
            go install github.com/cosmtrek/air@latest
            echo "✅ air installé."
        fi
        air
        return 0
    fi

    # Si aucun projet n'''est détecté, on en crée un.
    # Un nom de projet est requis.
    if [ -z "$1" ]; then
        echo "Usage: gin <nom_du_projet>"
        return 1
    fi

    local project_name="$1"

    # Vérifie si le dossier existe déjà
    if [ -d "$project_name" ]; then
        echo "❌ Le dossier '$project_name''' existe déjà."
        return 1
    fi

    echo "✨ Création du projet Go '$project_name'''..."
    mkdir -p "$project_name"
    cd "$project_name" || return

    # Initialise le module Go
    go mod init "$project_name"

    # Installe Gin
    echo "📦 Installation de Gin..."
    go get -u github.com/gin-gonic/gin

    # Crée l'''arborescence du projet
    echo "📁 Création de l'''arborescence..."
    mkdir controllers middleware models routes static templates

    # Crée le fichier main.go de base
    echo "✍️ Création du fichier main.go..."
    cat << '''EOF''' > main.go
package main

import (
    "net/http"
    "github.com/gin-gonic/gin"
)

func main() {
    r := gin.Default()

    r.GET("/", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "message": "Hello World from Gin!",
        })
    })

    // Lancement du serveur sur le port 8080
    r.Run()
}
EOF

    echo "✅ Projet '$project_name''' créé avec succès."
    echo "👉 Pour démarrer le serveur, exécutez :"
    echo "   cd $project_name"
    echo "   gin"
} 

