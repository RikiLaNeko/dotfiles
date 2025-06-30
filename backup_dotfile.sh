#!/bin/sh

sudo -v
while true; do
  sudo -v
  sleep 60
done 2>/dev/null &

DEST_DIR="$(pwd)"

echo "Début de la sauvegarde des dotfiles dans $DEST_DIR"

copy_dir_content() {
  local src=$1
  local dest=$2

  if [ -d "$src" ]; then
    mkdir -p "$dest"
    cp -r --preserve=mode,timestamps "$src/"* "$dest/"
    echo "Copié contenu de $src dans $dest"
  else
    echo "Attention : dossier $src n'existe pas"
  fi
}

copy_file() {
  local src=$1
  local dest=$2

  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dest")"
    cp --preserve=mode,timestamps "$src" "$dest"
    echo "Copié fichier $src vers $dest"
  else
    echo "Attention : fichier $src n'existe pas"
  fi
}

# Sauvegarde des fichiers/dossiers
copy_dir_content "$HOME/.config/hypr" "$DEST_DIR/hypr"
copy_dir_content "$HOME/.config/waybar" "$DEST_DIR/waybar"
copy_file "$HOME/.config/starship.toml" "$DEST_DIR/starship/starship.toml"
copy_file "$HOME/.zshrc" "$DEST_DIR/zsh/.zshrc"

if [ -d "/etc/nixos" ]; then
  mkdir -p "$DEST_DIR/nixos"
  sudo cp -r --preserve=mode,timestamps /etc/nixos/* "$DEST_DIR/nixos/"
  echo "Copié /etc/nixos dans $DEST_DIR/nixos"
else
  echo "Attention : /etc/nixos n'existe pas."
fi

echo "Sauvegarde terminée."

# Gestion Git
cd "$DEST_DIR" || exit 1

echo
echo "Préparation du commit Git..."

git add .

echo "Entrez un message de commit décrivant les modifications :"
read -r commit_message

if [ -z "$commit_message" ]; then
  echo "Message vide, commit annulé."
  exit 1
fi

git commit -m "$commit_message" && echo "Commit effectué."

echo "Poussée vers le dépôt distant..."
git push && echo "Push réussi." || echo "Erreur lors du push."
