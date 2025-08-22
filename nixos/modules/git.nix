{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Git & DevOps Tools ---
    git # Système de contrôle de version
    gitleaks # Scanner de secrets dans les dépôts
    gh #Cli Github
    diff-so-fancy
  ];
}

