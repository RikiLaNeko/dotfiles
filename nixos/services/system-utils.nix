{ config, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      group = "users";
      user = "dedsec";
      dataDir = "/home/dedsec/Syncthing";
      configDir = "/home/dedsec/Syncthing/.config/Syncthing";
    };
    tailscale = {
      enable = true;
    };
    seatd = {
      enable = true;
    };
  };

  security.pam.services.swaylock.enable = true;
}
