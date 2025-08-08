# === Zsh Config ===

# Chemin des complétions custom
fpath=("$HOME/.zsh/completions" $fpath)

# Chargement de chaque partie
source "$HOME/.zsh/plugins.zsh"
source "$HOME/.zsh/aliases.zsh"
source "$HOME/.zsh/functions.zsh"
source "$HOME/.zsh/server.zsh"
source "$HOME/.zsh/customCommand.zsh"
source "$HOME/.zsh/customDocker.zsh"
source "$HOME/.zsh/customNix.zsh"

# Completions
autoload -Uz compinit && compinit

# Initialisation des outils
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias)"
eval "$(direnv hook zsh)"
eval "$(laravel completion zsh)"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# PATH & éditeurs
export PATH="$HOME/.bun/bin:$PATH"
export EDITOR=nvim
export VISUAL=yazi
export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"


eval $(thefuck --alias)
