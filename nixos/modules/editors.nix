{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim # Editeur de texte puissant
  ];
}

