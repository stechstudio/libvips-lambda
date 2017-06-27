#!/bin/sh \
set -e

fetchSource jpeg https://github.com/libjpeg-turbo/libjpeg-turbo/archive/${VERSION_JPEG}.tar.gz

if [ ! -f "Makefile" ]; then
    autoreconf -fiv
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-jpeg8 \
        --without-turbojpeg
else
    echo "Already Configured"
fi
make install-strip