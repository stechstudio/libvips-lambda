#!/bin/sh \
set -e

fetchSource gif http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/giflib/giflib-${VERSION_GIF}.tar.gz
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