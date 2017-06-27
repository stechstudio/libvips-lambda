#!/bin/sh
set -e

fetchSource orc http://gstreamer.freedesktop.org/data/src/orc/orc-${VERSION_ORC}.tar.xz
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
cd ${TARGET}/lib
rm -rf liborc-test-*