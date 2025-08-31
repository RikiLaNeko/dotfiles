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
alias gri='gradle init --type java-application --dsl kotlin --project-name app --package xyz.dedsecm --test-framework junit --incubating'


# 🦜 Kotlin
alias kbuild="kotlinc Main.kt -include-runtime -d main.jar"
alias krun="java -jar main.jar"

# 🧩 .NET / C#
alias dotr="dotnet run"
alias dotb="dotnet build"

# Svelte
alias snew="bunx sv create"


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


alias df=duf
alias dig=dog

alias man=tldr
