#!/bin/bash

# Github container registry
REGISTRY="ghcr.io"
PROJECT="reconcycle" #has to match github organisation/username
VERSION_TAG="libgazebo7"

build_and_tag () {
  docker build $IMAGE -t $REGISTRY/$PROJECT/$IMAGE:$VERSION_TAG
  docker tag $REGISTRY/$PROJECT/$IMAGE:$VERSION_TAG $PROJECT/$IMAGE:$VERSION_TAG
}

IMAGES=("gzweb" "panda-gzweb")

for IMAGE in ${IMAGES[@]}; do build_and_tag; done
