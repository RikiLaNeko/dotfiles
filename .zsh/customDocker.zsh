# dcr: Gérer ou créer des conteneurs Docker de manière interactive.
dcr() {
  # Mode 1: Gestion interactive si aucun argument n'est fourni
  if [ "$#" -eq 0 ]; then
    local container_info
    container_info=$(docker ps -a --format "{{.ID}}	{{.Image}}	{{.Names}}	{{.Status}}" | fzf --header "Select a container" --preview 'docker inspect {1}' --height 40% --layout=reverse)

    if [ -z "$container_info" ]; then
      echo "❌ Aucune sélection."
      return 1
    fi

    local container_id=$(echo "$container_info" | awk '{print $1}')
    local container_name=$(echo "$container_info" | awk '{print $3}')

    echo "Que faire avec le conteneur $container_name ($container_id) ?"
    local actions=("exec (shell)" "logs" "stop" "start" "rm" "inspect" "quit")
    local action
    select action in "${actions[@]}"; do
      case "$action" in
        "exec (shell)")
          docker exec -it "$container_id" /bin/bash
          break
          ;;
        "logs")
          docker logs -f "$container_id"
          break
          ;;
        "stop")
          docker stop "$container_id"
          break
          ;;
        "start")
          docker start "$container_id"
          break
          ;;
        "rm")
          read "confirm?Êtes-vous sûr de vouloir supprimer le conteneur $container_name? (y/N) "
          if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
            docker rm "$container_id"
          else
            echo "Suppression annulée."
          fi
          break
          ;;
        "inspect")
          docker inspect "$container_id" | bat
          break
          ;;
        "quit")
          break
          ;;
        *)
          echo "Option invalide."
          break
          ;;
      esac
    done
  # Mode 2: Création rapide avec sélection d'image
  else
    local image_query="$1"
    local selected_image
    selected_image=$(docker search "$image_query" --format "{{.Name}}" | fzf --header "Select an image for interactive session" --height 40% --layout=reverse)

    if [ -z "$selected_image" ]; then
      echo "❌ Aucune image sélectionnée."
      return 1
    fi

    echo "Image sélectionnée : $selected_image"

    local container_name
    local ports

    read "container_name?Nom du conteneur (optionnel, Entrée pour auto) : "
    read "ports?Mapper les ports (ex: 8080:80, optionnel) : "

    local run_cmd="docker run -it"
    if [ -n "$container_name" ]; then
      run_cmd="$run_cmd --name $container_name"
    fi
    if [ -n "$ports" ]; then
      run_cmd="$run_cmd -p $ports"
    fi

    run_cmd="$run_cmd $selected_image"

    echo "Commande exécutée : $run_cmd"
    eval "$run_cmd"
  fi
}

# dcc: Créer et démarrer un conteneur Docker en mode détaché (-d).
dcc() {
  local selected_image

  # Si aucun argument, lister les images locales. Sinon, chercher sur Docker Hub.
  if [ "$#" -eq 0 ]; then
    selected_image=$(docker images --format "{{.Repository}}:{{.Tag}}	{{.ID}}	{{.Size}}" | fzf --header "Select a local image to run detached" --preview 'docker image inspect {2}' --height 40% --layout=reverse | awk '{print $1}')
  else
    local image_query="$1"
    selected_image=$(docker search "$image_query" --format "{{.Name}}" | fzf --header "Select an image to run detached" --height 40% --layout=reverse)
  fi

  # Si aucune image n'est sélectionnée (l'utilisateur a quitté fzf), on arrête.
  if [ -z "$selected_image" ]; then
    echo "❌ Aucune image sélectionnée."
    return 1
  fi

  echo "Image sélectionnée : $selected_image"

  # Logique de création commune
  local container_name
  local ports

  read "container_name?Nom du conteneur (optionnel, Entrée pour auto) : "
  read "ports?Mapper les ports (ex: 6379:6379, optionnel) : "

  local run_cmd="docker run -d"
  if [ -n "$container_name" ]; then
    run_cmd="$run_cmd --name $container_name"
  fi
  if [ -n "$ports" ]; then
    run_cmd="$run_cmd -p $ports"
  fi

  run_cmd="$run_cmd $selected_image"

  echo "Lancement de la commande : $run_cmd"
  local container_id
  container_id=$(eval "$run_cmd")
  
  if [ $? -eq 0 ]; then
    echo "✅ Conteneur démarré en mode détaché."
    echo "   ID court: $(echo "$container_id" | cut -c1-12)"
  else
    echo "❌ Erreur lors du démarrage du conteneur."
  fi
}

# dps: Affiche les conteneurs Docker de manière interactive avec fzf.
# Accepte les mêmes arguments que `docker ps` (ex: -a pour tous les conteneurs).
dps() {
  docker ps "$@" --format "table {{.ID}}	{{.Image}}	{{.Status}}	{{.Ports}}	{{.Names}}" | fzf --header="[Docker PS] Conteneurs" --height 40% --layout=reverse
}

# dpl: Affiche les logs d'un conteneur avec des options de formatage.
dpl() {
  local container_id
  if [ "$#" -eq 0 ]; then
    local container_info
    container_info=$(docker ps -a --format "{{.ID}}	{{.Image}}	{{.Names}}	{{.Status}}" | fzf --header "Select a container to view logs" --height 40% --layout=reverse)
    
    if [ -z "$container_info" ]; then
      echo "❌ Aucune sélection."
      return 1
    fi
    container_id=$(echo "$container_info" | awk '{print $1}')
  else
    container_id="$1"
  fi

  local container_name=$(docker ps -a --filter "id=$container_id" --format "{{.Names}}")
  echo "Options de logs pour le conteneur $container_name:"
  
  local actions=("Follow (raw)" "Follow (with timestamps)" "Show all (paged)" "Filter (follow)" "Pretty JSON (paged)" "quit")
  local action
  select action in "${actions[@]}"; do
    case "$action" in
      "Follow (raw)")
        docker logs -f "$container_id"
        break
        ;;
      "Follow (with timestamps)")
        docker logs -f -t "$container_id"
        break
        ;;
      "Show all (paged)")
        docker logs -t "$container_id" | bat --paging=always --language=log
        break
        ;;
      "Filter (follow)")
        read "pattern?Entrez le motif à filtrer (grep) : "
        docker logs -f -t "$container_id" | grep --color=always "$pattern"
        break
        ;;
      "Pretty JSON (paged)")
        if ! command -v jq &>/dev/null; then
          echo "❌ 'jq' n'est pas installé. Impossible de formater le JSON." >&2
          echo "   Sur NixOS, vous pouvez l'installer avec : nix-shell -p jq" >&2
          return 1
        fi
        
        local json_logs=$(docker logs "$container_id" | jq -R 'fromjson? // empty')
        if [ -z "$json_logs" ]; then
          echo "
🔎 Aucune ligne au format JSON valide n'a été trouvée dans les logs de ce conteneur.
"
          read -s -k "?Appuyez sur une touche pour retourner au menu..."
        else
          echo "$json_logs" | bat --paging=always --language=json
        fi
        break
        ;;
      "quit")
        break
        ;;
      *)
        echo "Option invalide."
        break
        ;;
    esac
  done
}

# dpsh: Ouvre un shell dans un conteneur (interactif si aucun argument).
dpsh() {
  local container_id
  if [ "$#" -eq 0 ]; then
    local container_info
    container_info=$(docker ps -a --format "{{.ID}}	{{.Image}}	{{.Names}}	{{.Status}}" | fzf --header "Select a container to open a shell" --height 40% --layout=reverse)
    
    if [ -z "$container_info" ]; then
      echo "❌ Aucune sélection."
      return 1
    fi
    container_id=$(echo "$container_info" | awk '{print $1}')
  else
    container_id="$1"
  fi
  
  docker exec -it "$container_id" /bin/bash
}

# drm: Supprime des conteneurs de manière interactive (multi-sélection).
drm() {
  local containers_to_delete
  containers_to_delete=$(docker ps -a --format "{{.ID}}	{{.Names}}	{{.Image}}	{{.Status}}" | \
    fzf --multi --header "Select containers to delete (multi-select with Tab)" \
        --preview 'docker inspect {1}' --height 50% --layout=reverse | awk '{print $1}')

  if [ -z "$containers_to_delete" ]; then
    echo "❌ Aucune sélection."
    return 1
  fi

  echo "Conteneurs à supprimer :"
  echo "$containers_to_delete"
  read "confirm?Êtes-vous sûr de vouloir forcer la suppression de ces conteneurs ? (y/N) "
  if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
    echo "$containers_to_delete" | xargs docker rm -f
  else
    echo "Suppression annulée."
  fi
}

# dri: Supprime des images de manière interactive (multi-sélection).
dri() {
  local images_to_delete
  images_to_delete=$(docker images --format "{{.Repository}}:{{.Tag}}	{{.ID}}	{{.Size}}" | \
    fzf --multi --header "Select images to delete (multi-select with Tab)" \
        --preview 'docker image inspect {2}' --height 50% --layout=reverse | awk '{print $2}')

  if [ -z "$images_to_delete" ]; then
    echo "❌ Aucune sélection."
    return 1
  fi

  echo "Images à supprimer :"
  echo "$images_to_delete"
  read "confirm?Êtes-vous sûr de vouloir supprimer ces images ? (y/N) "
  if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
    echo "$images_to_delete" | xargs docker rmi
  else
    echo "Suppression annulée."
  fi
}

# dco: Gestionnaire interactif pour Docker Compose.
dco() {
  if [ ! -f "docker-compose.yml" ] && [ ! -f "compose.yml" ]; then
    echo "❌ Aucun fichier docker-compose.yml ou compose.yml trouvé."
    return 1
  fi

  echo "Actions Docker Compose disponibles :"
  local actions=("up -d" "down" "logs -f" "ps" "build" "exec" "quit")
  local action
  select action in "${actions[@]}"; do
    case "$action" in
      "up -d")
        docker compose up -d
        break
        ;;
      "down")
        docker compose down
        break
        ;;
      "logs -f")
        docker compose logs -f
        break
        ;;
      "ps")
        docker compose ps
        break
        ;;
      "build")
        docker compose build
        break
        ;;
      "exec")
        local service
        service=$(docker compose ps --services | fzf --header "Select a service to exec into")
        if [ -n "$service" ]; then
          docker compose exec "$service" /bin/bash
        else
          echo "❌ Aucune sélection."
        fi
        break
        ;;
      "quit")
        break
        ;;
      *)
        echo "Option invalide."
        break
        ;;
    esac
  done
}

# dstat: Affiche les statistiques en direct des conteneurs sélectionnés.
dstat() {
  local containers_to_stat
  containers_to_stat=$(docker ps --format "{{.ID}}	{{.Names}}	{{.Image}}" | \
    fzf --multi --header "Select containers to show stats for (multi-select with Tab)" --height 40% --layout=reverse | awk '{print $1}')

  if [ -z "$containers_to_stat" ]; then
    echo "❌ Aucune sélection."
    return 1
  fi

  docker stats $(echo "$containers_to_stat")
}

# dvol: Gère les volumes Docker de manière interactive.
dvol() {
  # Mode création
  if [ "$1" = "create" ]; then
    local volume_name="$2"
    if [ -z "$volume_name" ]; then
      read "volume_name?Nom du volume à créer : "
    fi
    if [ -z "$volume_name" ]; then
      echo "❌ Nom de volume non fourni."
      return 1
    fi
    docker volume create "$volume_name"
    return 0
  fi

  # Mode suppression interactive (par défaut)
  local volumes_to_delete
  volumes_to_delete=$(docker volume ls --format "{{.Name}}" | \
    fzf --multi --header "Select volumes to delete (multi-select with Tab)" \
        --preview 'docker volume inspect {}' --height 50% --layout=reverse)

  if [ -z "$volumes_to_delete" ]; then
    echo "❌ Aucune sélection."
    return 1
  fi

  echo "Volumes à supprimer :"
  echo "$volumes_to_delete"
  read "confirm?Êtes-vous sûr de vouloir supprimer ces volumes ? (y/N) "
  if [[ "$confirm" =~ ^[yY]($|[eE][sS])$ ]]; then
    echo "$volumes_to_delete" | xargs docker volume rm
  else
    echo "Suppression annulée."
  fi
}

# dprune: Assistant de nettoyage interactif pour Docker.
dprune() {
  echo "Assistant de nettoyage Docker."
  echo "Choisissez une action :"

  local actions=(
    "Supprimer les conteneurs arrêtés"
    "Supprimer les images inutilisées (dangling)"
    "Supprimer les images non utilisées (pas seulement dangling)"
    "Supprimer les volumes non utilisés"
    "Supprimer les réseaux non utilisés"
    "Tout nettoyer (système complet)"
    "quit"
  )
  local action
  select action in "${actions[@]}"; do
    case "$action" in
      "Supprimer les conteneurs arrêtés")
        docker container prune
        break
        ;;
      "Supprimer les images inutilisées (dangling)")
        docker image prune
        break
        ;;
      "Supprimer les images non utilisées (pas seulement dangling)")
        docker image prune -a
        break
        ;;
      "Supprimer les volumes non utilisés")
        docker volume prune
        break
        ;;
      "Supprimer les réseaux non utilisés")
        docker network prune
        break
        ;;
      "Tout nettoyer (système complet)")
        echo "ATTENTION : Ceci supprimera tous les conteneurs, images, volumes et réseaux non utilisés."
        docker system prune -a
        break
        ;;
      "quit")
        break
        ;;
      *)
        echo "Option invalide."
        break
        ;;
    esac
  done
}
