{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    asciinema #Record terminal
    asciinema-agg #Convert terminal vid into GIF
    obs-studio #Record vid
    kdePackages.kdenlive
  ];
}
