{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Fun & Divers ---
    cowsay # Vache parlante
    steam # Plateforme de jeux
    osu-lazer-bin # Jeu musical
    xonotic # FPS libre
    yazi # Navigateur de fichiers TUI
    minikube # Kubernetes local
  ];
}

