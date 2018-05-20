#!/bin/sh
set -e

VERSION_VIPS="8.5.6"
VERSION_PHP="7.1.7"
VERSION_PHPVIPS="1.0.7"

# Is docker available?
if ! type docker >/dev/null; then
  echo "Please install docker"
  exit 1
fi

echo "Building ..."
docker build -t dev-lambda amazonlinux
docker \
    run \
    --rm \
    -e "VERSION_VIPS=${VERSION_VIPS}" \
    -e "VERSION_PHP=${VERSION_PHP}" \
    -e "VERSION_PHPVIPS=${VERSION_PHPVIPS}" \
    -e "BUILD_PHP=YES" \
    -v $PWD:/packaging \
    dev-lambda \
    sh -c "/packaging/build/sts.sh"