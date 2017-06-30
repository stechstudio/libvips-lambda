#!/bin/sh
set -e

if [ $# -lt 3 ]; then
  echo
  echo "Usage: $0 VERSION_VIPS VERSION_PHP VERSION_PHPVIPS"
  echo "Build shared libraries for libvips and its dependencies via containers"
  echo "Then compile PHP against the same dependencies and build php-vips-ext"
  echo
  echo "Please specify the libvips VERSION, e.g. 8.5.6"
  echo "Please specify the PHP VERSION, e.g. 7.1.6"
  echo "Please specify the php-vips-ext VERSION, e.g. 1.0.7"
  echo
  exit 1
fi

VERSION_VIPS="$1"
VERSION_PHP="$2"
VERSION_PHPVIPS="$3"

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
    sh -c "/packaging/build/vips.sh"