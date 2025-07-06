<h1 align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="55"/>
  Dotfiles &amp; <span style="color:#6a3d8b;">GNU Stow</span>
</h1>
<p align="center">
  <b>Symlinks propres, configs modulaires, installation instantanée</b>
</p>

<p align="center">
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-blue?logo=nixos&logoColor=white&style=flat-square"></a>
  <a href="https://www.gnu.org/software/stow/"><img src="https://img.shields.io/badge/Stow-portable-green?logo=gnu&style=flat-square"></a>
  <a href="https://github.com/ghostty-org/ghostty"><img src="https://img.shields.io/badge/Ghostty-terminal-7B7B7B?logo=terminal&style=flat-square"></a>
  <a href="https://hyprland.org/"><img src="https://img.shields.io/badge/Hyprland-wayland-6C63FF?logo=wayland&style=flat-square"></a>
  <a href="https://neovim.io/"><img src="https://img.shields.io/badge/Neovim-lazyvim-57A143?logo=neovim&style=flat-square"></a>
  <a href="https://ohmyz.sh/"><img src="https://img.shields.io/badge/Zsh-ohmyzsh-333?logo=gnu-bash&style=flat-square"></a>
  <a href="https://starship.rs/"><img src="https://img.shields.io/badge/Starship-fast-7d5fff?logo=starship&style=flat-square"></a>
  <a href="https://catppuccin.com/"><img src="https://img.shields.io/badge/Theme-Catppuccin-F5C2E7?logo=paintpalette&logoColor=white&style=flat-square"></a>
</p>

---

## 🧐 Pourquoi ce setup ? Pourquoi Stow ?

- **Déploiement instantané** : un `git clone` + `stow` et tout est prêt, sur n’importe quel Linux.
- **Modularité** : chaque app a son dossier, j’active/désactive ce que je veux sans rien casser.
- **Hygiène** : zéro pollution, tout est symlinké proprement, mon `$HOME` reste clean.
- **Versionning** : tout sur GitHub, rollback/test ultra simple.
- **QOL/productivité** : prompts custom, alias utiles, config ultra-rapide pour bosser ou bidouiller.

---

## 🚀 Aperçu de mon environnement

- **Distro** : NixOS
- **WM/DE** : Hyprland
- **Terminal** : Ghostty
- **Shell** : Zsh + Oh My Zsh + plugins persos
- **Prompt** : Starship
- **Éditeur** : Neovim (LazyVim)
- **Launcher** : Wofi (Catppuccin)
- **Autres outils** : Tmux, Git, etc.

---

## 🏗️ Organisation du repo

```mermaid
graph TD
  Stow[stow/]
  Stow --> ZSH[zsh/.zshrc]
  Stow --> Starship[starship/.config/starship.toml]
  Stow --> NVIM[nvim/.config/nvim/]
  Stow --> Tmux[tmux/.config/tmux/tmux.conf]
  Stow --> Ghostty[ghostty/.config/ghostty/config]
  Stow --> Hypr[hypr/.config/hypr/hyprland.conf]
  Stow --> Wofi[wofi/.config/wofi/]
```

---

## 📦 Installer mes dotfiles ?

```bash
git clone https://github.com/RikiLaNeko/dotfiles.git
cd dotfiles/stow
stow .
```
Pour une seule app :
```bash
stow zsh
```

---

## 🛠️ Exemples à explorer

- `.zshrc` — prompt, alias, plugins, zsh-autosuggestions
- `starship.toml` — prompt rapide & stylé
- `nvim/` — config Neovim full Lua
- `hyprland.conf` — WM dynamique & custom
- `tmux.conf` — splits/sessions QOL
- `ghostty/config` — terminal moderne
- `wofi/` — launcher Catppuccin

---

## ✨ Ce que ça m’a changé

- **Réinstall instantanée** : nouveau PC, VM, chroot ? Je suis prêt direct.
- **Test de configs sans douleur** : j’active/je vire ce que je veux.
- **Confort de travail** : tout est pensé pour être rapide, lisible, joli (merci Catppuccin !)
- **Pas de magie noire** : pas de dépendances bizarres, tout est documenté.

---

<p align="center">
  <i>Merci à la <a href="https://catppuccin.com/">communauté Catppuccin</a> pour le style et l’inspi !</i>
</p>

---

> Un souci, une question ? Ouvre une issue ou ping-moi sur GitHub !
