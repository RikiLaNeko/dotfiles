{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Terminal & CLI tools ---
    ghostty # Terminal performant
    fzf # Fuzzy finder
    ripgrep # Recherche rapide dans fichiers
    fd # Recherche de fichiers
    tldr # Pages de man simplifiées
    atuin # Historique shell amélioré
    bat # `cat` avec coloration syntaxique
    eza # `ls` amélioré
    procs # `ps` moderne
    lsof # Liste fichiers ouverts
    tmux # Multiplexeur de terminal
    ncdu # Analyse disque
    rsync # Synchronisation de fichiers
    yazi # TUI file manager
    tmux # Terminal multiplexer
    zellij #Terminal multiplexer
    dysk #Better duf
    duf #Better df
    jq #Json processor
    nixpkgs-fmt
    dog #Better dig
    tshark # Montioring
    termshark #tshark TUI
    moreutils #Get more utils (If you didnt understood you stoopid)
  ];
}

