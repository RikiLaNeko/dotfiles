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

    # --- PHP ---
    php                    # Langage PHP
    symfony-cli           # CLI Symfony
    laravel               # Laravel (si dispo dans ton overlay sinon installer via composer)

    # --- Python ---
    python3               # Langage Python
    python3Packages.pip  # Gestionnaire de paquets Python
    python3Packages.virtualenv # Environnements virtuels Python

    # --- Go ---
    go                    # Langage Go
    gopls                 # Serveur de langage Go
    wails                 # Framework desktop Go

    # --- Rust ---
    rustup                # Rust toolchain installer
    cargo                 # Gestionnaire de paquets Rust
    cargo-tauri           # Outil de build pour Tauri apps
    rust-analyzer         # Serveur de langage Rust

    # --- Ruby ---
    ruby                  # Langage Ruby
    bundler               # Gestionnaire de paquets Ruby

    # --- .NET ---
    dotnet-sdk            # SDK .NET pour C#, F#, etc.

    # --- Global ---
    asdf-vm #Extendable version manager
    dbeaver-bin #Visualise DB

    ];
}
