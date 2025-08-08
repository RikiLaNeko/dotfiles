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

# dpl: Affiche les logs d'un conteneur (interactif si aucun argument).
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
  
  docker logs -f "$container_id"
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
