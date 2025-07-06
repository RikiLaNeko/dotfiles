{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gemini-cli #CLI for gemini IA
    fabric-ai #CLI to interact with ia (like with ollama)
  ];

  #Ollama (this config run on an Fking 3050, you maybe wanna kill it)
  services.ollama = {
  enable = true;
  acceleration = "cuda";
  };

  #open-webui (http://localhost:8080)
  services.open-webui.enable = true;
  services.open-webui.port = 6969;
}
