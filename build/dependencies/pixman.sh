#!/bin/sh
set -e

fetchSource pixman http://cairographics.org/releases/pixman-${VERSION_PIXMAN}.tar.gz
if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-libpng \
        --disable-arm-iwmmxt
else
    echo "Already Configured"
fi
make install-strip