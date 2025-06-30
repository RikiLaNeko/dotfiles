{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Réseau & Internet ---
    wget # Téléchargements
    curl # Requêtes HTTP
    dnsmasq # DNS/DHCP local
    nmap # Scan réseau
    httpie # Client HTTP ergonomique
    networkmanagerapplet # Applet GUI réseau
  ];
}

