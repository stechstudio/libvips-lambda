#!/bin/sh
set -e

fetchSource svg https://download.gnome.org/sources/librsvg/2.40/librsvg-${VERSION_SVG}.tar.xz
if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-tools \
        --disable-pixbuf-loader
else
    echo "Already Configured"
fi
make install-strip