<!--
README principal des dotfiles de RikiLaNeko
Dernière mise à jour : 2025-07-02
-->

<h1 align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="60"/> Dotfiles de <a href="https://github.com/RikiLaNeko">RikiLaNeko</a></h1>
<p align="center">
  <b>Configuration Unix élégante, modulaire & intelligente</b>
  <br/>
  <a href="https://nixos.org/">NixOS 25.05</a> • <a href="https://hyprland.org">Hyprland</a> • <a href="https://www.gnu.org/software/stow/">GNU Stow</a> • <a href="https://github.com/ghostty-org/ghostty">Ghostty</a> • <a href="https://github.com/catppuccin/catppuccin">Catppuccin</a>
</p>

<p align="center">
  <a href="https://nixos.org"><img src="https://img.shields.io/badge/NixOS-25.05-blue?logo=nixos&logoColor=white&style=flat-square" /></a>
  <a href="https://hyprland.org/"><img src="https://img.shields.io/badge/Hyprland-dynamic%20wm-9cf?logo=linux&style=flat-square"></a>
  <a href="https://github.com/catppuccin/catppuccin"><img src="https://img.shields.io/badge/Theme-Catppuccin-F5C2E7?logo=paintpalette&logoColor=white&style=flat-square"></a>
  <a href="https://github.com/RikiLaNeko/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/github/license/RikiLaNeko/dotfiles?style=flat-square"></a>
</p>

---

## 📖 Table des matières

- [Aperçu](#-aperçu)
- [Diagramme de structure](#-diagramme-de-structure)
- [Organisation & Workflow](#-organisation--workflow)
- [Dotfiles inclus](#-dotfiles-inclus)
- [Philosophie](#-philosophie)
- [Pour aller plus loin](#-pour-aller-plus-loin)
- [Crédits](#crédits)

---

## 🌟 Aperçu

Ce repo regroupe **tous mes dotfiles Unix** pour un setup moderne, modulaire, esthétique et portable.  
Optimisé pour :

- [NixOS 25.05](https://nixos.org/),
- [Hyprland](https://hyprland.org/) (Wayland WM),
- [GNU Stow](https://www.gnu.org/software/stow/),
- [Catppuccin](https://catppuccin.com/) (thème global),
- [Ghostty](https://github.com/ghostty-org/ghostty) (terminal nouvelle génération).

---

## 🗺️ Diagramme de structure

```mermaid
graph TD
  A[dotfiles/] --> B[stow/]
  B --> B1[zsh/.zshrc]
  B --> B2[starship/.config/starship.toml]
  B --> B3[nvim/.config/nvim/]
  B --> B4[tmux/.config/tmux/tmux.conf]
  B --> B5[ghostty/.config/ghostty/config]
  B --> B6[hypr/.config/hypr/hyprland.conf]
  A --> C[nixos/]
  C --> C1[configuration.nix]
  C --> C2[home.nix]
  A --> D[scripts/]
```

---

## 💼 Organisation & Workflow

- Configs rangées par app dans `stow/`, prêtes à être symlinkées grâce à [GNU Stow](https://www.gnu.org/software/stow/).
- Fichiers `.zshrc` ou autres en racine → `stow/zsh/.zshrc`
- Configs XDG (`.config/`) → `stow/xxx/.config/xxx/`
- Config NixOS et Home Manager dans `nixos/`

> Pour la gestion Stow, voir le [guide détaillé](./stow/README.md).

---

## 🦄 Dotfiles inclus

- **Zsh** : prompt moderne (Starship), plugins zinit, snippets, aliases, historique (Atuin), navigation rapide (zoxide)
- **Starship** : prompt cross-shell stylé Catppuccin
- **Neovim** : configuration Lua complète, plugins, ergonomie
- **Tmux** : splits, status bar, plugins TPM, keybinds smart (migration future vers Zellij)
- **Ghostty** : terminal nouvelle génération (Catppuccin, Iosevka)
- **Hyprland** : WM dynamique, gaps, blur, launchers custom
- **Waybar** : barres de status, quicklinks, intégration Ghostty/Nvim
- **Scripts** : helpers, automatisation

---

## 💡 Philosophie

- **Modularité** : chaque app indépendante, stow/unstow à volonté
- **Esthétique** : Catppuccin partout, police Iosevka, cohérence UX
- **Reproductibilité** : rebuild NixOS ou symlinks instantanés sur n’importe quel système
- **Automatisation** : scripts, snippets, aliases, rebuild facile

---

## 🪄 Pour aller plus loin

- [Gestion Stow (guide complet)](./stow/README.md)
- [Configuration NixOS avancée](./nixos/README.md)

---

## 🙏 Crédits

Merci à toutes les communautés open-source et à [Catppuccin](https://catppuccin.com/) pour l’inspiration visuelle.

---

> **Une question, une suggestion ? Ouvre une issue ou un PR !**
