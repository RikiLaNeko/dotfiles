#!/bin/sh

set -e

echo "Copie de /etc/nixos dans ./nixos (avec sudo)..."
sudo cp -r /etc/nixos ./nixos

echo "Changement de propriétaire et permissions dans ./nixos..."
sudo chown -R $(whoami):$(id -gn) ./nixos
chmod -R u+rw ./nixos

echo "Affichage des différences avec diff-so-fancy :"
git diff --color | diff-so-fancy

read -rp "Ajouter tous les fichiers modifiés à git ? (y/n) : " add_all
if [[ "$add_all" =~ ^[Yy]$ ]]; then
  git add .
else
  echo "Veuillez ajouter manuellement les fichiers avant de commiter."
  exit 1
fi

read -rp "Message de commit : " msg
if [[ -z "$msg" ]]; then
  echo "Message de commit vide, abandon."
  exit 1
fi

git commit -m "$msg"

branch=$(git rev-parse --abbrev-ref HEAD)
git push origin "$branch"

echo "Terminé avec succès."
