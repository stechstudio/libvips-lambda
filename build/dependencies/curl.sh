#!/bin/sh \
set -e

fetchSource curl https://github.com/curl/curl/releases/download/curl-${VERSION_CURL//./_}/curl-${VERSION_CURL}.tar.gz

if [ ! -f "CONFIGURED" ]; then
    LD_LIBRARY_PATH=${TARGET}/lib \
    ./configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking
    touch "CONFIGURED"
else
    echo "Already Configured"
fi

make install