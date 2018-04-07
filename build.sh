#! /bin/sh

REPO=ready2order/php
USAGE="./build.sh NAME VERSION [--push] [--login]"

# Ensure that script auto-stops on errors.
set -exo pipefail

echo "$@"

PUSH=$1
LOGIN=$2

if [ "$LOGIN" == "--login" ]; then
    echo $DOCKER_PW | docker login -u $DOCKER_USER  --password-stdin
fi

docker build -t $REPO:7.2.4-cli -f 7.2/stretch/cli/Dockerfile .
docker build -t $REPO:7.2.4-fpm -f 7.2/stretch/fpm/Dockerfile .

if [ "$PUSH" == "--push" ]; then
    echo "Pushing image with tag $FULL_TAG...";
    docker push $REPO:7.2.4-cli
    docker push  $REPO:7.2.4-fpm
fi
