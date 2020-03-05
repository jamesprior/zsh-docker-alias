#!/usr/bin/env zsh

__docker-alias_docker_exec() {
  print " 📦 intercepted call to $2, running 'docker exec -it $@'"
  docker exec -it $@
}


# This will find a docker container by looking for containers with the current
# directory mounted as a volume.  It will not match if the current directory
# is a subpath.  The return order is undefined, it will use the first returned
# container
function __docker-alias_container_for_path_by_mount() {
  local pwd=$(pwd -P)
  set -x
  local container_names=("${(@f)$(docker ps --filter "volume=$pwd" --filter "label=com.docker.compose.oneoff=False" --format {{.Names}})}")

  echo "${container_names[1]}"
}

function _docker-alias_maybe_docker() {
  # Find all container names with a mounted directory exactly matching
  # the current directory
  local container_name=$(__docker-alias_container_for_path_by_mount)

  if [ ! -z "${container_name}" ]; then
    __docker-alias_docker_exec ${container_name} $@
  else
    command $@
  fi
}

# Intercept calls to rails and check docker first
function rails() {
  _docker-alias_maybe_docker 'rails' $@
}

function rake() {
  _docker-alias_maybe_docker 'rake' $@
}

function bundle() {
  _docker-alias_maybe_docker 'bundle' $@
}