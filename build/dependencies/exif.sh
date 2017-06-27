#!/bin/sh \
set -e

fetchSource exif http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/libexif/libexif/${VERSION_EXIF}/libexif-${VERSION_EXIF}.tar.bz2

if [ ! -f "Makefile" ]; then
    autoreconf -fiv
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking
else
    echo "Already Configured"
fi

make install-strip