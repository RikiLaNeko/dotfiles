#!/bin/sh

set -e

# 1. Copie /etc/nixos dans ./nixos (dans le dossier courant)
echo "Copie de /etc/nixos dans ./nixos (avec sudo)..."
sudo cp -r /etc/nixos ./nixos

# 2. Affiche le diff avec diff-so-fancy
echo "Affichage des différences avec diff-so-fancy :"
git diff --color | diff-so-fancy

# 3. Demande d'ajout des fichiers
read -rp "Ajouter tous les fichiers modifiés à git ? (y/n) : " add_all
if [[ "$add_all" =~ ^[Yy]$ ]]; then
  git add .
else
  echo "Veuillez ajouter manuellement les fichiers avant de commiter."
  exit 1
fi

# 4. Demande du message de commit
read -rp "Message de commit : " msg

if [[ -z "$msg" ]]; then
  echo "Message de commit vide, abandon."
  exit 1
fi

# 5. Commit
git commit -m "$msg"

# 6. Push sur la branche courante
branch=$(git rev-parse --abbrev-ref HEAD)
git push origin "$branch"

echo "Terminé avec succès."
