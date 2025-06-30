{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Audio & Vidéo ---
    playerctl # Contrôle multimédia
    gimp # Éditeur d’images
    pavucontrol # Contrôle audio PulseAudio
    pulsemixer # Mixer en terminal
  ];
}

