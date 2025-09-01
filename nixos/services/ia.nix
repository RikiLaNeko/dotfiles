{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  #Ollama (this config run on an Fking 3050, you maybe wanna kill it)
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
    CUDA_VISIBLE_DEVICES = "0";
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    NVIDIA_VISIBLE_DEVICES = "0";
    OLLAMA_INTEL_GPU = "false";
  };
  };

  #open-webui (http://localhost:8080)
  services.open-webui.enable = true;
  services.open-webui.port = 6969;
}
