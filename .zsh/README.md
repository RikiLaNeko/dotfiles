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

**Description :** Formate la sortie d'une commande en un tableau propre et aligné.

**Utilisation :**
```bash
# Afficher les processus Docker dans un tableau bien formaté
docker ps | cols

# Afficher l'utilisation du disque
df -h | cols
```

---

### `show <NOM_DE_LA_COLONNE>`

**Description :** Extrait une seule colonne de la sortie d'une commande en se basant sur le nom de son en-tête.

**Utilisation :**
```bash
# Afficher uniquement la colonne IMAGE de la sortie de docker ps
docker ps | cols | show IMAGE

# Chercher une image sur Docker Hub et n'afficher que les noms
docker search redis | cols | show NAME
```

---

### `num`

**Description :** Ajoute un numéro de ligne (ID) à chaque ligne d'une sortie, en ignorant la première ligne (l'en-tête).

**Utilisation :**
```bash
# Lister les fichiers et les numéroter
ls -l | cols | num

# Chercher une image et numéroter les résultats
docker search redis | cols | show NAME | num
```

---

### `dcr [nom_de_l'image]`

**Description :** Une commande multifonction pour gérer Docker de manière interactive, inspirée par `nvim`.

**Utilisation :**

1.  **`dcr` (Mode interactif)**
    -   Lance `fzf` pour lister tous vos conteneurs (actifs ou non).
    -   Affiche un aperçu `docker inspect` pour le conteneur sélectionné.
    -   Après sélection, un menu propose des actions : `exec` (entrer dans le conteneur), `logs`, `stop`, `start`, `rm` (avec confirmation), ou `inspect`.

    ```bash
    # Lancer le gestionnaire interactif
    dcr
    ```

2.  **`dcr <recherche_image>` (Mode création)**
    -   Cherche une image sur Docker Hub avec le terme fourni.
    -   Lance `fzf` pour vous permettre de sélectionner l'image exacte dans les résultats.
    -   Lance un assistant pour créer et démarrer un nouveau conteneur à partir de l'image sélectionnée.
    -   Demande un nom pour le conteneur et les ports à mapper.
    -   Démarre le conteneur en mode interactif (`-it`).

    ```bash
    # Chercher "ubuntu" et sélectionner une image à lancer en mode interactif
    dcr ubuntu
    ```

---

### `dcc [recherche_image]`

**Description :** Crée et démarre un conteneur Docker en mode **détaché** (`-d`).

**Utilisation :**

1.  **`dcc` (Mode interactif - images locales)**
    -   Lance `fzf` pour lister toutes vos **images Docker locales**.
    -   Affiche un aperçu `docker image inspect`.
    -   Après sélection, lance l'assistant de création (nom, ports).

2.  **`dcc <recherche_image>` (Mode recherche - Docker Hub)**
    -   Cherche une image sur Docker Hub avec le terme fourni.
    -   Lance `fzf` pour sélectionner l'image exacte dans les résultats.
    -   Après sélection, lance l'assistant de création.

```bash
# Lister les images locales et en choisir une à lancer
dcc

# Chercher "redis" sur Docker Hub et en choisir une
# Chercher "redis" et sélectionner une image à lancer en arrière-plan
dcc redis
```

---

### `dps`

**Description :** Affiche les conteneurs Docker dans une liste interactive `fzf`.

**Utilisation :**
-   Affiche les conteneurs en cours avec leur ID, Image, Statut, Ports et Nom.
-   Accepte les arguments de `docker ps`, comme `-a` pour voir tous les conteneurs.

```bash
# Lister les conteneurs en cours de manière interactive
dps

# Lister TOUS les conteneurs (actifs et arrêtés)
dps -a
```

---

### `dpl [nom_ou_id_conteneur]`

**Description :** Affiche les logs d'un conteneur avec des options de formatage avancées.

**Utilisation :**
-   **Sans argument :** Lance `fzf` pour sélectionner un conteneur.
-   **Avec argument :** Agit directement sur le conteneur spécifié.
-   Après sélection, un menu propose plusieurs modes d'affichage :
    -   Suivi des logs en temps réel (`-f`), avec ou sans timestamps.
    -   Affichage de tous les logs (paginé avec `bat`).
    -   Filtrage des logs en temps réel avec `grep`.
    -   Formatage "pretty-print" pour les logs JSON (nécessite `jq`).

```bash
# Lancer le menu de logs interactif
dpl

# Accéder directement au menu pour le conteneur "mon_app"
dpl mon_app
```

---

### `dpsh [nom_ou_id_conteneur]`

**Description :** Ouvre un shell (`/bin/bash`) dans un conteneur.

**Utilisation :**
-   **Sans argument :** Lance `fzf` pour sélectionner un conteneur.
-   **Avec argument :** Ouvre un shell dans le conteneur spécifié.

```bash
# Sélectionner un conteneur pour y ouvrir un shell
dpsh

# Ouvrir un shell dans le conteneur "mon_app"
dpsh mon_app
```

---

### `drm`

**Description :** Supprime des conteneurs de manière interactive.

**Utilisation :**
-   Lance `fzf` en mode multi-sélection (`Tab` pour choisir).
-   Affiche un aperçu `docker inspect`.
-   Demande confirmation avant de forcer la suppression (`rm -f`).

```bash
# Lancer le sélecteur de conteneurs à supprimer
drm
```

---

### `dri`

**Description :** Supprime des images Docker locales de manière interactive.

**Utilisation :**
-   Lance `fzf` en mode multi-sélection (`Tab` pour choisir).
-   Affiche un aperçu `docker image inspect`.
-   Demande confirmation avant de supprimer.

```bash
# Lancer le sélecteur d'images à supprimer
dri
```

---

### `dco`

**Description :** Gestionnaire interactif pour Docker Compose.

**Utilisation :**
-   Doit être lancé dans un répertoire contenant un `docker-compose.yml`.
-   Affiche un menu d'actions : `up -d`, `down`, `logs`, `ps`, `build`, `exec`.
-   L'action `exec` permet de choisir le service via `fzf`.

```bash
# Lancer le gestionnaire interactif Docker Compose
dco
```

---

### `dstat`

**Description :** Affiche les statistiques d'utilisation des ressources (CPU, RAM, réseau) pour les conteneurs en temps réel.

**Utilisation :**
-   Lance `fzf` pour sélectionner un ou plusieurs conteneurs (`Tab`).
-   Affiche `docker stats` uniquement pour les conteneurs sélectionnés.

```bash
# Lancer le sélecteur de conteneurs à surveiller
dstat
```

---

### `dvol [create] [nom_volume]`

**Description :** Gère les volumes Docker.

**Utilisation :**
1.  **`dvol` (Mode suppression)**
    -   Lance `fzf` pour lister et sélectionner les volumes à supprimer (`Tab` pour la multi-sélection).
    -   Affiche un aperçu `docker volume inspect`.
    -   Demande confirmation avant de supprimer.

2.  **`dvol create [nom_volume]` (Mode création)**
    -   Crée un nouveau volume. Si le nom n'est pas fourni, il sera demandé.

```bash
# Lancer le sélecteur de volumes à supprimer
dvol

# Créer un volume nommé "my-data"
dvol create my-data
```

---

### `dprune`

**Description :** Lance un assistant de nettoyage interactif et sécurisé pour les ressources Docker.

**Utilisation :**
-   Affiche un menu pour choisir quoi nettoyer : conteneurs, images (dangling ou toutes), volumes, réseaux.
-   Propose une option pour un nettoyage complet du système.
-   Utilise les commandes `docker * prune` natives, qui demandent toujours une confirmation.

```bash
# Lancer l'assistant de nettoyage
dprune
```

---

### `nixm`

**Description :** Un gestionnaire interactif pour les opérations courantes de NixOS.

**Utilisation :**
-   Lance un menu pour rechercher des paquets, gérer les générations, nettoyer le store, éditer la configuration, voir les logs, appliquer ou annuler la configuration.

```bash
# Lancer le gestionnaire NixOS interactif
nixm
```
```
```