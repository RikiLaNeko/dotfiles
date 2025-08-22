{ pkgs, ... }:
{
  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    #docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
    podman-desktop # graphical tool for developing on containers and Kubernetes
    k3s
    minikube
    virtiofsd
  ];
}
