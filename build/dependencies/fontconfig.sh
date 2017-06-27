#!/bin/sh \
set -e

fetchSource fontconfig https://www.freedesktop.org/software/fontconfig/release/fontconfig-${VERSION_FONTCONFIG}.tar.bz2

if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-expat-includes=${TARGET}/include \
        --with-expat-lib=${TARGET}/lib \
        --sysconfdir=/var/task/etc
else
    echo "Already Configured"
fi

make install-strip