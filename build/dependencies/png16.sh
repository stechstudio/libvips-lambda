#!/bin/sh
set -e

fetchSource png16 http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/libpng/libpng16/${VERSION_PNG16}/libpng-${VERSION_PNG16}.tar.xz
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