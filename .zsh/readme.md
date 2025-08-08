# Mes Commandes ZSH Personnalisées

Ce fichier documente les fonctions et commandes personnalisées disponibles dans mon environnement ZSH.

---

### `phonix <nom_du_projet>`

**Description :** Crée ou démarre un projet [Phoenix Framework](https://www.phoenixframework.org/). La fonction détecte l'OS pour installer les dépendances (Elixir, Erlang, etc.) si elles sont manquantes. Si un projet existant est détecté, il lance le serveur de développement. Sinon, il crée un nouveau projet.

**Utilisation :**
```bash
# Créer un nouveau projet avec une base de données SQLite (par défaut)
phonix mon_super_projet

# Démarrer un projet existant
cd /chemin/vers/mon_super_projet/
phonix .
```

---

### `please`

**Description :** Exécute la commande précédente avec `sudo`. C'est un alias pratique pour les moments où l'on oublie les droits d'administrateur. Pour des raisons de sécurité, certaines commandes comme `cd` ou `export` ne peuvent pas être utilisées avec `please`.

**Utilisation :**
```bash
# Exemple : Oups, j'ai oublié sudo
apt install cowsay

# Pas de problème, on corrige
please
```

---

### `nvim`

**Description :** Ouvre Neovim. Si aucun fichier n'est spécifié, il lance `fzf` pour permettre une recherche floue interactive des fichiers dans le répertoire courant. Un aperçu du fichier sélectionné est affiché avec `bat`.

**Utilisation :**
```bash
# Ouvrir un fichier spécifique
nvim mon_fichier.txt

# Lancer fzf pour chercher un fichier à ouvrir
nvim
```

---

### `cols`

**Description :** Formate la sortie d'une commande en un tableau propre et aligné, avec un en-tête coloré en jaune et gras pour une meilleure lisibilité.

**Utilisation :**
```bash
# Afficher les processus Docker dans un tableau bien formaté
docker ps | cols

# Afficher l'utilisation du disque
df -h | cols
```

---

### `show <NOM_DE_LA_COLONNE>`

**Description :** Extrait une seule colonne de la sortie d'une commande en se basant sur le nom de son en-tête. L'en-tête de la colonne extraite est également coloré. Cette commande est conçue pour fonctionner avec `cols`.

**Utilisation :**
```bash
# Afficher uniquement la colonne IMAGE de la sortie de docker ps
docker ps | cols | show IMAGE

# Chercher une image sur Docker Hub et n'afficher que les noms
docker search redis | cols | show NAME
```
