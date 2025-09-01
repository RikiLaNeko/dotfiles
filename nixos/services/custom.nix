{config, pkgs,...}:
{
# Service pour changer automatiquement le thème GRUB
  systemd.services.grub-theme-cycler = {
    description = "GRUB Theme Cycler";
    after = [ "multi-user.target" ];
    wants = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/dedsec/dotfiles/.config/grub/cycler/cycler.sh --auto";
      User = "root";
      StandardOutput = "journal";
      StandardError = "journal";
      # Définir le PATH pour inclure les outils système NixOS
      Environment = [
        "PATH=/run/current-system/sw/bin:/nix/var/nix/profiles/system/sw/bin:/usr/bin:/bin"
        "NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix"
      ];
    };
    
    # Activer le service pour qu'il démarre automatiquement
    wantedBy = [ "multi-user.target" ];
  };


  # Optionnel: Timer pour exécuter périodiquement (au lieu d'au démarrage)
  # systemd.timers.grub-theme-cycler = {
  #   description = "Run GRUB Theme Cycler daily";
  #   timerConfig = {
  #     OnCalendar = "daily";
  #     Persistent = true;
  #   };
  #   wantedBy = [ "timers.target" ];
  # };
  
  # Nettoyage automatique des anciennes générations
  nix.gc = {
    automatic = true;
    dates = "weekly";          # ou "daily"
    options = "--delete-older-than 30d";  # garde 30 jours
  };

  # Nettoyage automatique des logs systemd aussi
  services.journald.extraConfig = ''
    SystemMaxUse=1G
    MaxRetentionSec=30day
  '';

}
