#!/bin/sh
set -e

fetchSource poppler https://poppler.freedesktop.org/poppler-${VERSION_POPPLER}.tar.xz
if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET}  \
         --sysconfdir=/etc   \
         --enable-shared \
         --disable-static \
         --enable-build-type=release \
         --enable-cmyk               \
         --enable-xpdf-headers       \
         --disable-dependency-tracking \
         --enable-libcurl \
         --enable-libopenjpeg=openjpeg2
else
    echo "Already Configured"
fi
make install-strip