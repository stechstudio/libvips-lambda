#!/bin/sh \
set -e

rm -rf ${DEPS}/tiff

fetchSource tiff http://download.osgeo.org/libtiff/tiff-${VERSION_TIFF}.tar.gz

# Apply patches for libtiff vulnerabilities reported since v4.0.7
VERSION_TIFF_GIT_MASTER_SHA=$(curl -Ls https://api.github.com/repos/vadz/libtiff/git/refs/heads/master | jq -r '.object.sha' | head -c7)
curl -Ls https://github.com/vadz/libtiff/compare/Release-v4-0-7...master.patch | patch -p1 -t || true

autoreconf -fiv

./configure  \
    --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking \
    --disable-mdi \
    --disable-pixarlog \
    --disable-cxx


make install-strip