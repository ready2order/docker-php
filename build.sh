#! /bin/sh

REPO=ready2order/php
USAGE="./build.sh NAME VERSION [--push] [--login]"
VERSION=7.2.7-1
TAG="$REPO:$VERSION"
LATEST_TAG="$REPO:latest"

# Ensure that script auto-stops on errors.
set -exou pipefail

echo "$@"

PUSH=""
LOGIN=""

for ARG in "${@:1}"
do
    echo "CHECKING ARG: $ARG"
	case "$ARG" in
		--push)
			PUSH="true"
		;;
		--login)
			LOGIN="true"
		;;
		*)
			echo "Unknown argument: $ARG"
			exit 1
		;;

	esac
done

if [ "$LOGIN" == "true" ]; then
    echo $DOCKER_PW | docker login -u $DOCKER_USER  --password-stdin
fi

docker build -t $TAG -f Dockerfile .
docker tag $TAG $LATEST_TAG

if [ "$PUSH" == "true" ]; then
    echo "Pushing image with tag $TAG...";
    docker push $TAG
    echo "Pushing latest tag: $LATEST_TAG"
    docker push $LATEST_TAG
fi
