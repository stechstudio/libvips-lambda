#!/bin/sh
set -e

fetchSource pango https://download.gnome.org/sources/pango/1.40/pango-${VERSION_PANGO}.tar.xz
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