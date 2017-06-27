#!/bin/sh \
set -e

fetchSource zlib http://zlib.net/zlib-${VERSION_ZLIB}.tar.xz

if [ ! -f "zlib.pc" ]; then
    ./configure \
        --prefix=${TARGET} \
        --uname=linux
else
    echo "Already Configured"
fi

make install

rm ${TARGET}/lib/libz.a