{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Communication & Email ---
    vesktop # Client Discord alternatif
    element-desktop # Client Matrix sécurisé
    thunderbird # Client mail
    protonmail-bridge # Accès IMAP/SMTP Protonmail
    protonmail-bridge-gui # GUI pour Protonmail Bridge
    teams-for-linux # Microsoft Teams sur Linux
    simplex-chat-desktop # Messagerie sécurisée P2P
  ];
}

