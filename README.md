# Dotfiles NixOS de RikiLaNeko

**Backup de ma configuration NixOS et de mes dotfiles pour un environnement de travail complet, reproductible et moderne.**

---

## Présentation

Ce dépôt contient la configuration complète de mon système NixOS, organisée en modules thématiques et pensée pour la personnalisation, le développement et l’efficacité sur un poste personnel.

- **Système principal** : NixOS, configuration modulaire.
- **Dotfiles** : gestion du shell Zsh, plugins, alias, et outils.
- **Environnement de bureau** : Hyprland (Wayland), outils graphiques et CLI.
- **Privé** : ce dépôt est privé, il contient mes préférences personnelles.

---

## Structure des dossiers

```
nixos/
 ├── configuration.nix         # Configuration principale du système NixOS
 ├── hardware-configuration.nix# Détection matérielle (généré automatiquement)
 └── modules/                  # Modules personnalisés, chaque aspect du système séparé
      ├── communication.nix    # Clients de messagerie & email
      ├── devtools.nix         # Outils de développement (Java, JS, C/C++)
      ├── editors.nix          # Éditeurs de texte (Neovim)
      ├── fun.nix              # Jeux et utilitaires ludiques
      ├── git.nix              # Outils Git & DevOps
      ├── hyprland.nix         # Environnement graphique Wayland/Hyprland
      ├── multimedia.nix       # Audio, vidéo et contrôle multimédia
      ├── network.nix          # Outils réseau
      ├── system-utils.nix     # Utilitaires système & hardware
      └── terminal-utils.nix   # Outils de terminal & CLI
zsh/
 └── .zshrc                    # Configuration du shell Zsh (plugins, alias, prompt)
```

---

## Principales fonctionnalités

- **Installation modulaire** : chaque aspect du système est dans un module dédié (édition, réseau, développement, etc.).
- **Gestion avancée du terminal** : [ghostty](https://github.com/mitchellh/ghostty), fzf, bat, eza, tmux, etc.
- **Shell moderne** : Zsh + plugins (zinit, fzf-tab, syntax-highlighting, autosuggestions, etc.).
- **Outils de développement** : Java (JDK, Maven, Gradle, Spring Boot), Kotlin, Bun, Clang, CMake, Just.
- **Environnement graphique Hyprland** : waybar, wofi, swww, grim, etc.
- **Productivité et fun** : cowsay, minikube, steam, osu, xonotic.
- **Gestion des polices** : fonts modernes (Fira Code, JetBrains Mono Nerd Font, Noto, etc.).
- **Support matériel avancé** : NVIDIA, Bluetooth, Docker, etc.
- **Internationalisation** : azerty/français, locales françaises et anglaises.

---

## Prérequis

- **NixOS** (recommandé : version récente)
- Matériel compatible avec Wayland/Hyprland si environnement graphique utilisé

---

## Installation

1. **Cloner ce dépôt** sur ta machine NixOS :
   ```sh
   git clone https://github.com/RikiLaNeko/dotfile.git
   cd dotfile/nixos
   ```

2. **Adapter la configuration matérielle** :
   - Vérifier ou adapter `hardware-configuration.nix` selon ton matériel.
   - Modifier les informations personnelles dans `configuration.nix` (utilisateur, nom de machine, etc.).

3. **Construire et appliquer la configuration** :
   ```sh
   sudo nixos-rebuild switch --flake .#
   ```

4. **Configurer le shell** :
   - Copier le fichier `zsh/.zshrc` dans ton `$HOME` si besoin.
   - Les plugins Zsh seront installés automatiquement au premier lancement.

---

## Astuces & Personnalisation

- **Ajouter ou retirer des modules** dans `nixos/configuration.nix` via la liste `imports = [...]`.
- **Modifier les alias et plugins** dans `zsh/.zshrc`.
- **Changer les outils installés** en éditant les modules dans `nixos/modules/`.

---

## Crédits & Inspirations

- [NixOS](https://nixos.org/)
- [Hyprland](https://hyprland.org/)
- [zinit](https://github.com/zdharma-continuum/zinit)
- [ghostty](https://github.com/mitchellh/ghostty)
- Les projets open source inspirant la configuration.

---

## Licence

> Dépôt **privé** : usage personnel uniquement.
