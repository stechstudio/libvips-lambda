#!/bin/sh \
set -e



fetchSource croco https://download.gnome.org/sources/libcroco/0.6/libcroco-${VERSION_CROCO}.tar.xz

if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking
else
    echo "Already Configured"
fi

make install-strip