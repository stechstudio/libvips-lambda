#!/bin/sh
set -e

fetchSource xslt https://git.gnome.org/browse/libxslt/snapshot/libxslt-${VERSION_XLST}.tar.xz
if [ ! -f "Makefile" ]; then
    ./autogen.sh
    ./configure  \
        --prefix=${TARGET} \
        --disable-static \
        --with-libxml-src=${DEPS}/xml2
else
    echo "Already Configured"
fi
make install-strip

