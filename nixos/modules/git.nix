{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Git & DevOps Tools ---
    git # Système de contrôle de version
    gitleaks # Scanner de secrets dans les dépôts
    lazygit # UI Git en terminal
    lazydocker # UI Docker en terminal
    lazysql # UI SQL en terminal
  ];
}

