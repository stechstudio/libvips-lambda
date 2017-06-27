#!/bin/sh
set -e

if [ $# -lt 1 ]; then
  echo
  echo "Usage: $0 VERSION"
  echo "Build shared libraries for libvips and its dependencies via containers"
  echo
  echo "Please specify the libvips VERSION, e.g. 8.3.3"
  echo
  exit 1
fi
VERSION_VIPS="$1"

# Is docker available?
if ! type docker >/dev/null; then
  echo "Please install docker"
  exit 1
fi

echo "Building ..."
docker build -t dev-lambda amazonlinux
docker run --rm -e "VERSION_VIPS=${VERSION_VIPS}" -v $PWD:/packaging dev-lambda sh -c "/packaging/build/vips.sh"
