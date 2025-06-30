# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.hyprland={
  enable = true;
  xwayland.enable = true;
  };

  xdg.portal = {
  enable = true;
  extraPortals = [pkgs.xdg-desktop-portal-gtk];
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


  services.xserver.videoDrivers = [ "nvidia" ];
  services.libinput.enable = true;

  virtualisation.docker.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
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
  # --- Editors ---
  neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

  # --- Networking & Terminal Tools ---
  wget
  ghostty
  fzf  # Fuzzy finder
  ripgrep # Search tool
  fd # Fast file search
  tldr # Simplified man pages
  atuin # Command history tool
  bat # cat better alternative
  eza # ls better alternative
  playerctl
  brightnessctl # Contrôle de luminosité
  thermald # Gestion thermique


  # --- Wayland & Hyprland ---
  waybar # Status bar for Wayland
  wofi # Application launcher for Wayland
  swww # Wayland screen locker
  waypaper # Wayland wallpaper setter
  vesktop # Wayland compositor
  element-desktop
  obsidian #Notion alternative
  thunderbird
  networkmanagerapplet
  protonmail-bridge-gui
  protonmail-bridge


  # --- Browsers ---
  teams-for-linux # Microsoft Teams for Linux
  simplex-chat-desktop # Messagerie sécurisée et privée

  # --- Git Tools ---
  git # Git version control
  gitleaks # Scan git repos (or files) for secrets
  lazygit # Git UI for the terminal
  lazydocker # Docker UI for the terminal
  lazysql # SQL client for the terminal

  # --- IDEs ---
  jetbrains.idea-ultimate # IntelliJ IDEA Ultimate Edition
  jetbrains.webstorm # WebStorm IDE
  jetbrains.clion # CLion IDE
  jetbrains-toolbox # JetBrains toolbox for managing IDEs

  # --- System Monitoring & Utilities ---
  fastfetch # System information fetcher
  starship # Cross-shell prompt
  btop #htop better alternative
  nvtopPackages.nvidia
  ncdu # Analyseur d'espace disque
  procs
  lsof
  tmux
  vulkan-loader
  vulkan-tools

  # --- File Management & Compression ---
  ranger # Gestionnaire de fichiers en ligne de commande
  rsync # Synchronisation de fichiers
  zip # Compression d'archives

  # --- Network Tools ---
  dnsmasq # Serveur DNS et DHCP léger
  curl # Requêtes HTTP/HTTPS
  nmap # Scan de réseau
  httpie # better postman
  pavucontrol
  pulsemixer

  # --- Security & DevOps ---
  gnupg # Gestion des clés GPG
  vault # Gestion des secrets

  # --- JSON & Diff Tools ---
  jq # Manipulation de JSON
  diff-so-fancy # Affichage des diff Git plus esthétique

  # --- Fun & Misc ---
  cowsay # Pour un peu de fun
  minikube
  steam
  osu-lazer-bin
  xonotic # FPS arena open-source
  grim
  slurp
  swappy
  wl-clipboard
  nautilus
  gimp
  glib
  swaynotificationcenter
  adwaita-icon-theme
  yazi

  # --- Development Tools ---
  #Javascript
  bun

  # Java
  jdk21 # OpenJDK 21
  kotlin # Kotlin compiler
  spring-boot-cli # Spring Boot CLI
  maven # Apache Maven build tool
  gradle # Gradle build tool

  # C/C++
  clang # LLVM C/C++ compiler
  cmake # Build automation tool
  just # Command runner for CI/CD-like tasks

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  

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
    TERMINAL = "ghostty";
    DEFAULT_TERM = "ghostty";
    EDITOR= "nvim";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
