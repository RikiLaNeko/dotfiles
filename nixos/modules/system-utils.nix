{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Système & Matériel ---
    fastfetch # Infos système
    starship # Invite shell stylée
    btop # UI système
    nvtopPackages.nvidia # Monitoring GPU NVIDIA
    vulkan-loader # Support Vulkan
    vulkan-tools # Outils Vulkan
    stow #Tool for managing the installation of multiple software packages in the same run-time directory tree
    mosh #SSH but..Better
    mtr #better ping
    glances #Stat dashboard
    iotop #top but for io
    dool #dstat alternative
    progress #Monitoring
    ipcalc #subnet calc
    magic-wormhole #P2P,E2E ecnrypted file transfer
    thefuck #The Fuck is a magnificent app
    swaylock-effects
    libnotify
  ];

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
    seatd={
        enable = true;
      };
  };

security.pam.services.swaylock.enable = true;
}

