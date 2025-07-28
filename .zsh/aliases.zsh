# 📝 Commandes de base
alias vim=nvim
alias c="clear"
alias e="exit"
alias cat=bat

# 📂 Navigation
alias ..="cd .."
alias ...="cd ../.."
alias cds="cd ~/.config"
alias cdc="cd ~/Code"
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

# ⚙️ Dev & tools
alias nb='nix build'
alias nr='nix run'
alias ns='nix shell'
alias ni='nix develop'
alias cz='cargo check && cargo clippy && cargo fmt'
alias rb='cargo run'
alias tidycode="$HOME/Code/Perso/Languages/Bash/Organize.sh"
alias tauri="cargo tauri"
alias code="codium"
alias f=fuck

# 🧠 Utilitaires divers
alias please="sudo $(fc -ln -1)"
alias pb-status='ps aux | grep protonmail-bridge'
alias blame="systemd-analyze blame"
alias cchain="systemd-analyze critical-chain"
alias y=yazi
alias top=btop

