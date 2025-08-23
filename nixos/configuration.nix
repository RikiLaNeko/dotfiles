# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # On crée une référence vers le paquet défini dans votre flake local
  nekoShellPkg = (builtins.getFlake "path:/home/dedsec/Code/Perso/nekoToolBox/nekoShell").packages.${pkgs.system}.default;
in

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./containers/podman.nix
      ./modules/android.nix
      ./services/android.nix
      ./modules/archives.nix
      ./modules/communication.nix
      ./modules/container.nix
      ./modules/cybersecurity.nix
      ./modules/devtools.nix
      ./modules/editors.nix
      ./modules/fun.nix
      ./modules/gamedev.nix
      ./modules/git.nix
      ./modules/hyprland.nix
      ./modules/ia.nix
      ./services/ia.nix
      ./modules/lazy.nix
      ./modules/multimedia.nix
      ./modules/network.nix
      ./modules/recording.nix
      ./modules/system-utils.nix
      ./services/system-utils.nix
      ./modules/terminal-utils.nix
      ./modules/wallet.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub = {
  enable = true;
  efiSupport = true;
  efiInstallAsRemovable = true;  # installe dans /EFI/BOOT/BOOTX64.EFI
  device = "nodev";               # obligatoire pour NixOS
  };
  boot.loader.grub.theme = "/home/dedsec/dotfiles/.config/grub/themes/minegrub-world-sel-theme/minegrub-world-selection";
  boot.loader.grub.configurationLimit = 10; #garde seulement 10 entrées dans GRUB



  boot.kernelParams = [
  "cgroup_enable=cpuset"
  "cgroup_enable=memory"
  "cgroup_enable=hugetlb"
  "cgroup_no_v1=all"
  "systemd.unified_cgroup_hierarchy=1"
  ];


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.zsh.enable = true;
  programs.zoxide.enable = true;

  services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = true; # Activer les animations
      animation = "matrix"; # Utiliser l'animation Matrix
      animation_fps = 24; # Cadence d'images pour l'animation (optionnel)
      # Autres paramètres pour personnaliser l'apparence
      # Les paramètres spécifiques peuvent varier selon la version de Ly
      hide_borders = true;
      margin_box_h = 2;
      margin_box_v = 1;
      input_len = 34;
      min_refresh_delta = 5;
      term_reset_cmd = "tput reset";
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };




  services.xserver.videoDrivers = [ "nvidia" ];
  services.libinput.enable = true;


  networking.hostName = "dedsec-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dedsec = {
    isNormalUser = true;
    description = "dedsec";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "libvirtd" "seat" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
    #shell = "${nekoShellPkg}/bin/nekoShell";
  };


  users.users.root = {
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.jetbrains-mono
  ];



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  ##########################
  # Graphismes & Hardware  #
  ##########################
  hardware.graphics.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:14:0:0";
  };

  hardware.nvidia-container-toolkit.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.printing.enable = true;
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  environment.variables = {
    TERM = "ghostty";
    DEFAULT_TERM = "ghostty";
    EDITOR = "nvim";
  };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
