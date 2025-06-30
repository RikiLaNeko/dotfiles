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
  ];
}

