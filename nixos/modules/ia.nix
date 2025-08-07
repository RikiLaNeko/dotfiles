{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gemini-cli #CLI for gemini IA
    fabric-ai #CLI to interact with ia (like with ollama)
  ];
}
