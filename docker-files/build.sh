#!/bin/bash

# Github container registry
REGISTRY="ghcr.io"
PROJECT="reconcycle"
VERSION_TAG="kinetic"

build_and_tag () {
  docker build $IMAGE -t $REGISTRY/$PROJECT/$IMAGE:$VERSION_TAG
  docker tag $REGISTRY/$PROJECT/$IMAGE:$VERSION_TAG $PROJECT/$IMAGE:$VERSION_TAG
}

IMAGES=("reconcycle-cell-visualization")

for IMAGE in ${IMAGES[@]}; do build_and_tag; done
