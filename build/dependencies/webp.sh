#!/bin/sh
set -e

fetchSource webp http://downloads.webmproject.org/releases/webp/libwebp-${VERSION_WEBP}.tar.gz
if [ ! -f "Makefile" ]; then
    ./configure  \
    --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking \
    --disable-neon \
    --enable-libwebpmux \
    --with-pngincludedir=${TARGET}/include \
    --with-pnglibdir=${TARGET}/lib
else
    echo "Already Configured"
fi
make install-strip