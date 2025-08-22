{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # --- Développement Java ---
    jdk21 # OpenJDK 21
    kotlin # Langage JVM moderne
    ktor-cli # Framework léger pour services HTTP en Kotlin
    hibernate # ORM Java (souvent utilisé avec Spring)
    spring-boot-cli # Outils Spring Boot
    maven # Outil de build Java classique
    gradle # Outil de build moderne
    scenebuilder # Interface graphique pour JavaFX

    # --- Développement JavaScript / TypeScript ---
    bun # Runtime JS rapide (alternatif à Node)
    nodejs # Runtime JS standard
    nest-cli # CLI pour NestJS (framework TypeScript backend)
    electron-bin

    # --- C/C++ ---
    gcc # Compilateur GNU C/C++
    clang # Compilateur LLVM C/C++
    cmake # Générateur de build multiplateforme
    just # Command runner simple (alternative à make)
    gnumake
    coreboot-toolchain.i386
    coreboot-toolchain.x64
    gdb

    # --- PHP ---
    php # Langage PHP
    symfony-cli # CLI pour Symfony
    laravel # Framework Laravel (si dispo dans le channel, sinon via composer)
    php84Packages.composer #Composer

    # --- Python ---
    python3 # Langage Python
    python3Packages.pip # Gestionnaire de paquets Python
    python3Packages.virtualenv # Environnements virtuels Python
    jupyter-all
    python312Packages.pytest

    # --- Go ---
    go # Langage Go
    gopls # Serveur de langage Go pour LSP
    wails # Framework desktop en Go (WebView + Go)
    wkhtmltopdf
    air

    # --- Rust ---
    rustup # Rustup pour gérer toolchains
    cargo # Gestionnaire de paquets Rust
    cargo-tauri # Build d'apps Tauri (desktop)
    rust-analyzer # Serveur de langage Rust

    # --- Ruby ---
    ruby # Langage Ruby
    bundler # Gestionnaire de dépendances Ruby
    rubyPackages.railties #RubyOnRails legacy
    rails-new #RubyOnRails (avec docker ainsi pas de soucis de dépendances)

    # --- .NET ---
    dotnet-sdk # SDK .NET (C#, F#, etc.)
    mono # Implémentation libre de .NET (legacy)

    # --- Erlang / BEAM ---
    erlang # Langage fonctionnel temps réel
    gleam # Langage statiquement typé pour la VM BEAM
    beam26Packages.elixir # Langage Elixir (fonctionnel concurrent)

    # --- Zig ---
    zig # Langage système moderne et minimaliste

    # --- Haskell ---
    haskell-ci # Outils CI pour Haskell

    # --- Lua ---
    lua # Langage léger et embeddable
    love # Framework de jeux en 2D avec Lua

    # --- Pascal ---
    fpc # Free Pascal Compiler

    # --- ASM ---
    nasm 
    bochs

    # --- Langages supplémentaires ---
    crystal # Langage compilé inspiré de Ruby
    ada # Langage pour systèmes critiques (Ada/SPARK)
    dmd # Compilateur officiel du langage D
    nim # Langage compilé moderne, performant et expressif

    # --- Outils globaux ---
    asdf-vm # Version manager extensible (multi-langages)
    dbeaver-bin # Interface graphique pour bases de données

    # --- Bibliothèques GUI ---
    gtk3 # Lib graphique GTK3
    #webkitgtk_6_0# Moteur de rendu WebKit GTK
    libyaml

    # --- Outils de packaging ---
    nsis # Générateur d'installateurs Windows
    upx # Compresseur d'exécutables
  ];
}

