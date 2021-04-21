#!/bin/bash

# Github container registry
REGISTRY="ghcr.io"
PROJECT="reconcycle"
VERSION_TAG="kinetic"

push() {
  docker image push $REGISTRY/$PROJECT/$IMAGE:$VERSION_TAG 
}

IMAGES=("ros-devel" "gazebo" "reconcycle-simulation")

for IMAGE in ${IMAGES[@]}; do push; done

