{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Wayland & Hyprland ---
    waybar # Barre de statut
    wofi # Lanceur d'application
    swww # Changement de fond d'écran
    waypaper # Outil de fond d'écran
    grim # Capture d'écran
    slurp # Sélection de zone
    swappy # Annotateur d’image
    wl-clipboard # Clipboard Wayland
    swaynotificationcenter # Centre de notifications
    adwaita-icon-theme # Thème d’icônes
    nautilus # Gestionnaire de fichiers GUI
    glib # Dépendance GTK
    brightnessctl # Contrôle de luminosité
    thermald # Gestion thermique
  ];
}

