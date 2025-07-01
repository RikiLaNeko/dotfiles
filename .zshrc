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
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

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
alias ls="eza --icons=always --color"
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
alias rm=shred
alias pb-status='ps aux | grep protonmail-bridge'


export EDITOR=nvim
export VISUAL=yazi

# Initialisation de Starship pour un prompt rapide et personnalisable
eval "$(starship init zsh)"

# Initialisation d'Atuin pour l'historique des commandes
eval "$(atuin init zsh)"

# Initialisation de zoxide
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"




# Load Angular CLI autocompletion.
source <(ng completion script)
export PATH="/home/dedsec/.bun/bin:$PATH"
export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"

