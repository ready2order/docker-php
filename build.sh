#! /bin/sh

REPO=ready2order/php
USAGE="./build.sh NAME (VERSION|--git-hash) [--push]"

echo "$@"

NAME=$1
VERSION=$2
PUSH=$3

if [ -z "$NAME" ]; then
    echo $USAGE
    exit 1;
fi

DOCKERFILE=""

case "$NAME" in
    fpm-alpine) DOCKERFILE=DockerfileFPMAlpine
        ;;
    *) echo "Invalid name: $NAME" && exit 1
        ;;
esac

if [ -z "$VERSION" ]; then
    echo $USAGE
fi

if [ "$VERSION" == "--git-hash" ]; then
    VERSION=$(git rev-parse HEAD)
fi

FULL_TAG="$REPO:$NAME-$VERSION"

docker build -t $FULL_TAG -f $DOCKERFILE . || exit 1

if [ "$3" == "--push" ]; then
    echo "Pushing image with tag $FULL_TAG..."
    docker push $FULL_TAG || exit 1
fi


