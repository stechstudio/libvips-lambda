#!/bin/sh \
set -e

fetchSource gsf https://download.gnome.org/sources/libgsf/1.14/libgsf-${VERSION_GSF}.tar.xz
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