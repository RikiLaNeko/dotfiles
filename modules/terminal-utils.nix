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
    ranger # Navigateur de fichiers CLI
    rsync # Synchronisation de fichiers
    zip # Compression
  ];
}

