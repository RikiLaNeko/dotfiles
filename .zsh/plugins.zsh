# === Zinit Setup ===
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# === Zinit Plugins ===
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# === OMZ Plugins & Snippets ===
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::git-auto-fetch
zinit snippet OMZP::git-commit
zinit snippet OMZP::gitignore
zinit snippet OMZP::aliases
zinit snippet OMZP::alias-finder
zinit snippet OMZP::gh
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::bun
zinit snippet OMZP::podman
zinit snippet OMZP::dotnet
zinit snippet OMZP::eza
zinit snippet OMZP::fancy-ctrl-z
zinit snippet OMZP::fzf
zinit snippet OMZP::gem
zinit snippet OMZP::golang
zinit snippet OMZP::gradle
zinit snippet OMZP::laravel5
zinit snippet OMZP::minikube
zinit snippet OMZP::ruby
zinit snippet OMZP::rust
zinit snippet OMZP::rsync
zinit snippet OMZP::ssh
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::symfony6
zinit snippet OMZP::tailscale
zinit snippet OMZP::tldr
zinit snippet OMZP::vi-mode
zinit snippet OMZP::virtualenv
zinit snippet OMZP::web-search

# Rejoue le cache
zinit cdreplay -q

