{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit # TUI Git en terminal
    # lazydocker # TUI Docker en terminal <- Remplacer par Podman-TUI / Podman-desktop
    lazysql # TUI SQL en terminal
    lazyjournal #TUI for journalctl, file system logs, as well as Docker and Podman containers
    lazycli #Tool to static turn CLI commands into TUIs
  ];
}
