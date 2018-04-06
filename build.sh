#! /bin/sh

REPO=ready2order/php
USAGE="./build.sh NAME (VERSION|--git-hash) [--push]"

# Ensure that script auto-stops on errors.
set -euxo pipefail

echo "$@"

NAME=$1
VERSION=$2
PUSH=$3
LOGIN=$4

if [ -z "$NAME" ]; then
    echo $USAGE
    exit 1;
fi

DOCKERFILE=""

case "$NAME" in
    fpm-alpine)
        DOCKERFILE=DockerfileFPMAlpine
        ;;
    *)
        echo "Invalid name: $NAME"
        ;;
esac

if [ -z "$VERSION" ]; then
    echo $USAGE
    exit 1
fi

if [ "$VERSION" == "--git-hash" ]; then
    VERSION=$(git rev-parse HEAD)
fi

FULL_TAG="$REPO:$NAME-$VERSION"

if [ ""$LOGIN" == "--login" ]; then
    echo $DOCKER_PW | docker login -u $DOCKER_USER  --password-stdin
fi

docker build -t $FULL_TAG -f $DOCKERFILE .

if [ "$3" == "--push" ]; then
    echo "Pushing image with tag $FULL_TAG..."
    docker push $FULL_TAG || exit 1
fi

