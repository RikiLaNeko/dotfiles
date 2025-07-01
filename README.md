<h1 align="center">Dotfiles de <a href="https://github.com/RikiLaNeko">RikiLaNeko</a></h1>
<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="80" alt="Logo"/>
</p>
<p align="center">
  <b>Gestion élégante & modulaire de mes configurations Unix grâce à GNU Stow</b>
  <br/>
  <a href="https://nixos.org/">NixOS</a> • <a href="https://www.gnu.org/software/stow/">GNU Stow</a> • <a href="https://github.com/ghostty-org/ghostty">Ghostty</a>
</p>

---

## ✨ Présentation

Bienvenue sur mon repo de **dotfiles** !  
Ce dépôt centralise toutes mes configurations pour une installation simple, propre et versionnée, grâce à [GNU Stow](https://www.gnu.org/software/stow/).

- **Facile à déployer sur plusieurs machines**
- **Compatible NixOS et autres distributions Unix**
- **Inclut mes configs pour Ghostty, Hyprland, Wofi, etc.**
- **Inspiré par la philosophie KISS : Keep It Simple & Stow!**

---

## 🚀 Installation rapide

1. **Clone ce dépôt où tu veux (typiquement dans `~/dotfiles`)** :
   ```sh
   git clone https://github.com/RikiLaNeko/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Installe [GNU Stow](https://www.gnu.org/software/stow/) si besoin** :
   ```sh
   # Sous NixOS
   nix-env -iA nixos.stow
   # Sous Arch
   sudo pacman -S stow
   # Sous Debian/Ubuntu
   sudo apt install stow
   ```

3. **Déploie les dotfiles dans ton `$HOME`** :
   ```sh
   stow bash
   stow nvim
   stow ghostty
   stow hypr
   # ...et tous les modules que tu veux !
   ```

---

## 📦 Comment ça marche ? (Méthode Stow)

- Chaque dossier (ex : `bash`, `nvim`, `ghostty`) contient une arborescence qui sera liée dans ton `$HOME`.
- Exemple :  
  `~/dotfiles/bash/.bashrc` → sera symlinké automatiquement dans `~/.bashrc` grâce à Stow.
- Tu peux stow/un-stow à volonté, sans polluer ton répertoire personnel.

---

## 🛠️ Configs et outils inclus

- **Ghostty** : Terminal moderne et rapide
- **Hyprland** : WM dynamique sous Wayland
- **Wofi** : Menu d’application stylé Catppuccin
- **NixOS** : Des snippets pour la configuration système
- **CSS** : Thèmes pour divers outils graphiques
- ...et bien plus !

---

## 📁 Exemple de structure

```
dotfiles/
├──.zshrc
├── nvim/
│   └── .config/nvim/init.vim
├── ghostty/
│   └── .config/ghostty/config
├── hypr/
│   └── .config/hypr/hyprland.conf
└── ...
```

---

## 💡 Astuces

- Tu veux tout stower d’un coup ?  
  `stow .` (attention : vérifie que tout est prêt !)
- Pour retirer une config :  
  `stow -D nvim`
- Besoin d’un shell script de lancement ou d’un hook NixOS ? Regarde dans le dossier `scripts/`.

---

## 🙏 Remerciements

- [Catppuccin](https://catppuccin.com/) pour les thèmes
- La communauté NixOS & GNU/Linux
- Les auteurs d’outils open-source

---

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" width="200"/>
</p>

<p align="center">
  <sub>Fait avec ❤️ par <a href="https://github.com/RikiLaNeko">RikiLaNeko</a></sub>
</p>
