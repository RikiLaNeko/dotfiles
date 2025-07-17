# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::git-auto-fetch
zinit snippet OMZP::git-commit
zinit snippet OMZP::gitignore
zinit snippet OMZP::gh
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::bun
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
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
zinit snippet OMZP::thefuck
zinit snippet OMZP::tldr
zinit snippet OMZP::tmux
zinit snippet OMZP::vi-mode
zinit snippet OMZP::virtualenv
zinit snippet OMZP::web-search

fpath=("$HOME/.zsh/completions" $fpath)
# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#Alias
alias vim=nvim
alias ls="eza --icons=always --color always"
alias e="exit"
alias c="clear"
alias cat=bat
alias man=tldr
alias grep=rg
alias cp='rsync -a --info=progress2'
alias ping=mtr
alias blame="systemd-analyze blame"
alias cchain="systemd-analyze critical-chain"
alias ps=procs
alias rmf=shred
alias find="fd --color=always"
alias ll="eza --icons=always --color --long --group-directories-first"
alias f=fuck
alias pb-status='ps aux | grep protonmail-bridge'
alias top=btop
alias tauri="cargo tauri"
alias code="codium"
alias tidycode="$HOME/Code/Perso/Languages/Bash/Organize.sh"


#PATH
export PATH="/home/dedsec/.bun/bin:$PATH"

#Config 
export EDITOR=nvim
export VISUAL=yazi
export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"


# Initialisation de Starship pour un prompt rapide et personnalisable
eval "$(starship init zsh)"

# Initialisation d'Atuin pour l'historique des commandes
eval "$(atuin init zsh)"

# Initialisation de zoxide
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias)"

# Load Angular CLI autocompletion.
source <(ng completion script)

