{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip
    unp
    p7zip
    unzip
  ];
}


