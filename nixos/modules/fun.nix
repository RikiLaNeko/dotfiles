{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Fun & Divers ---
    cowsay # Vache parlante
    osu-lazer-bin # Jeu musical
    xonotic # FPS libre
    minikube # Kubernetes local
    lutris
    wineWowPackages.stable
    winetricks
    dxvk
    prismlauncher
    calibre
  ];
}

