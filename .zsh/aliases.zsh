# 📝 Commandes de base
alias vim=nvim
alias c="clear"
alias e="exit"
alias cat=bat

# 📂 Navigation
alias ..="cd .."
alias ...="cd ../.."
alias cds="cd ~/dotfiles/.config"
alias cdc="cd ~/Code/Perso"
alias cdd="cd ~/Downloads"

# ⚙️ Système
alias ps=procs
alias ports="procs -n pid,user,cpu,mem,port,cmd | grep LISTEN"
alias rmf=shred
alias cp='rsync -a --info=progress2'
alias ping=mtr

# 🔍 Recherche
alias grep='rg --smart-case --color=always'
alias find="fd --color=always"

# 📁 Listage
alias ls="eza --icons=always --color always"
alias ll="eza --icons=always --color --long --group-directories-first"

# 🐍 Python
alias py=python
alias pym="python main.py"
alias venv="python -m venv .venv && source .venv/bin/activate"
alias jn="jupyter notebook"
alias pytest="pytest --maxfail=5 --disable-warnings -q"

# 🦀 Rust
alias cbr="cargo build --release"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"
alias cl="cargo clippy"

# 🐹 Go
alias gob="go build"
alias gor="go run"
alias got="go test"
alias goi="go install"
alias gom="go mod tidy"

# 🧱 C / C++
alias cbuild="gcc -Wall -Wextra -o main main.c"
alias ccbuild="g++ -Wall -Wextra -std=c++20 -o main main.cpp"
alias run="./main"

# 💾 Pascal
alias pbuild="fpc main.pas"

# ☕ Java
alias jbuild="javac Main.java"
alias jrun="java Main"

# 🦜 Kotlin
alias kbuild="kotlinc Main.kt -include-runtime -d main.jar"
alias krun="java -jar main.jar"

# 🧩 .NET / C#
alias dotr="dotnet run"
alias dotb="dotnet build"

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


# ⚙️ Dev & tools
alias nb='nix build'
alias nr='nix run'
alias ns='nix shell'
alias ni='nix develop'
alias tidycode="$HOME/Code/Perso/Languages/Bash/Organize.sh"
alias tauri="cargo tauri"
alias code="codium ."
alias f="fuck"

# 🧠 Utilitaires divers
alias pb-status='ps aux | grep protonmail-bridge'
alias blame="systemd-analyze blame"
alias cchain="systemd-analyze critical-chain"
alias y=yazi
alias top=btop
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

# 🛠️ NixOS System Management
alias nswitch="sudo nixos-rebuild switch"
alias nboot="sudo nixos-rebuild boot"
alias ntest="sudo nixos-rebuild test"
alias nbuild="sudo nixos-rebuild build"
alias nedit="sudo nvim /etc/nixos/configuration.nix"
alias nvimcfg="nvim /etc/nixos/configuration.nix"
alias nflake="sudo nixos-rebuild switch --flake .#$(hostname)"
alias nclean="sudo nix-collect-garbage -d"
alias nlog="journalctl -b -p err"

