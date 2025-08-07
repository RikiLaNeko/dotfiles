{ config, pkgs, ... }:

{
  #Ollama (this config run on an Fking 3050, you maybe wanna kill it)
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  #open-webui (http://localhost:8080)
  services.open-webui.enable = true;
  services.open-webui.port = 6969;
}
