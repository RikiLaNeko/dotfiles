{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # --- Développement Java ---
    jdk21 # OpenJDK 21
    kotlin # Langage JVM moderne
    spring-boot-cli # Outils Spring Boot
    maven # Outil de build Java
    gradle # Build tool moderne

    # --- Développement JavaScript ---
    bun # Runtime JS rapide
    nodejs #Nodejs

    # --- C/C++ ---
    clang # Compilateur LLVM C/C++
    cmake # Générateur de build C/C++
    just # Command runner simple
  ];
}

