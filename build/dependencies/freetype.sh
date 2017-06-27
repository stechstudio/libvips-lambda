#!/bin/sh \
set -e

fetchSource freetype http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/freetype/freetype2/${VERSION_FREETYPE}/freetype-${VERSION_FREETYPE}.tar.gz

if [ ! -f "CONFIGURED" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static
    touch "CONFIGURED"
else
    echo "Already Configured"
fi

make install