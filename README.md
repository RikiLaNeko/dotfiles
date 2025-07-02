<!--
README NixOS · dotfiles de RikiLaNeko
Dernière mise à jour : 2025-07-02
-->

<h1 align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="55"/>
  <span style="color:#7aa2f7;font-weight:bold;">NixOS 25.05</span> & <span style="color:#f5c2e7;font-weight:bold;">Hyprland</span> - <span style="color:#a6e3a1;">Configuration avancée</span>
</h1>
<p align="center">
  <b>Déclaratif, modulaire, reproductible – pour un OS Unix à ton image</b>
  <br/>
  <a href="https://nixos.org"><img src="https://img.shields.io/badge/NixOS-25.05-blue?logo=nixos&logoColor=white&style=flat-square" /></a>
  <a href="https://hyprland.org/"><img src="https://img.shields.io/badge/Hyprland-Wayland%20WM-9cf?logo=linux&style=flat-square"></a>
  <a href="https://catppuccin.com/"><img src="https://img.shields.io/badge/Theme-Catppuccin-F5C2E7?logo=paintpalette&logoColor=white&style=flat-square"></a>
</p>

---

## 📖 Sommaire

- [Introduction](#introduction)
- [Diagramme & Structure](#diagramme--structure)
- [Utilisation rapide](#utilisation-rapide)
- [Workflow avancé (Flakes & Home Manager)](#workflow-avancé-flakes--home-manager)
- [Modules personnalisés & astuces](#modules-personnalisés--astuces)
- [Bonnes pratiques](#bonnes-pratiques)
- [Roadmap & évolutions](#roadmap--évolutions)
- [Liens utiles](#liens-utiles)

---

## 🌟 Introduction

Ce dossier regroupe **toute ma configuration NixOS** :

- Système complet, reproductible à l’identique sur toute machine.
- Setup design & moderne : Hyprland (Wayland), Ghostty, Catppuccin, Waybar...
- Gestion modulaire : configuration, modules, scripts, thèmes, hardware.
- **Vers le full Nix** : Home Manager et Flakes intégrés ou en transition.

---

## 🗺️ Diagramme & Structure

```mermaid
graph TD
  N[nixos/] --> N1[configuration.nix]
  N --> N2[hardware-configuration.nix]
  N --> N3[home.nix (Home Manager)]
  N --> N4[modules/]
  N --> N5[themes/]
  N --> N6[secrets/]
```

**Structure type** :

```
nixos/
├── configuration.nix            # Config système principale
├── hardware-configuration.nix   # Généré par NixOS
├── home.nix                     # Config utilisateur Home Manager (ou standalone)
├── modules/                     # Modules persos (wm, terminal, apps…)
├── themes/                      # Thèmes Catppuccin, autres
├── secrets/                     # Secrets, tokens, variables privées
└── ...
```

---

## ⚡ Utilisation rapide

### 1. Cloner et positionner la config

```bash
git clone https://github.com/RikiLaNeko/dotfiles.git
cd dotfiles/nixos
```

### 2. Adapter les fichiers

- Change `hostName`, user, hardware, chemins, etc. dans `configuration.nix`.
- Vérifie la section `imports` pour activer tes modules.

### 3. Build & switch (classique)

```bash
sudo nixos-rebuild switch -I nixos-config=configuration.nix
```

### 4. Avec flakes (recommandé)

- Active les flakes dans `/etc/nixos/flake.nix` ou au root du repo.
- Commande build :

  ```bash
  sudo nixos-rebuild switch --flake .#
  ```

### 5. Home Manager (intégré ou standalone)

- Si intégré : `home.nix` importé dans `configuration.nix`.
- Sinon en standalone :

  ```bash
  home-manager switch --flake .#
  ```

---

## 🔥 Workflow avancé (Flakes & Home Manager)

- **Flakes** : portabilité, versionning, canaux, reproductibilité totale.
- **Home Manager** : tout ce qui touche l’utilisateur (dotfiles, apps, shell, themes) géré en pur Nix.
- **Modules persos** : pour factoriser la config (ex : module `hyprland`, `ghostty`, `waybar`, etc).

---

## 🧩 Modules personnalisés & astuces

- **modules/** : factorise ta config pour chaque app/service (ex: un module par WM, terminal, environnement graphique…).
- **themes/** : partage de palettes, Catppuccin, templates pour cohérence visuelle.
- **secrets/** : variables privées, fichiers sensibles (à gitignore !)
- **scripts/** : hooks, helpers, automation post-install.

> **Astuce** : Commente chaque option, isole tes variables, et split ta config pour la maintenance future.

---

## 💎 Bonnes pratiques

- Versionne tout (sauf secrets)
- Ne laisse rien de critique en dehors de la config
- Préfère Home Manager pour les dotfiles utilisateur
- Utilise les flakes pour la portabilité et la reproductibilité
- Modifie tes modules plutôt que des gros fichiers monolithiques

---

## 🚀 Roadmap & évolutions

- [ ] Migration complète vers Home Manager pour tous les dotfiles utilisateur
- [ ] Remplacer tmux par **Zellij** (multiplexer terminal nouvelle gen)
- [ ] Factoriser tous les modules (Hyprland, Ghostty, Waybar, etc)
- [ ] Flakes et canaux personnalisés
- [ ] Scripts onboarding automatique
- [ ] Tests CI sur la config Nix
- [ ] Documentation approfondie (EN/FR, guides spécifiques)

---

## 🔗 Liens utiles

- [NixOS](https://nixos.org/)
- [Hyprland](https://hyprland.org/)
- [Home Manager](https://nix-community.github.io/home-manager/index.html)
- [Catppuccin pour Nix](https://github.com/catppuccin/nix)
- [Zellij](https://zellij.dev/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)

---

> **Besoin d’aide, envie de contribuer ou de discuter config ? Ouvre une issue ou un PR !**
