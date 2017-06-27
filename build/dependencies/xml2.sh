#!/bin/sh
set -e

fetchSource xml2 http://xmlsoft.org/sources/libxml2-${VERSION_XML2}.tar.gz
if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --with-html \
        --with-zlib=${TARGET}
else
    echo "Already Configured"
fi
make install-strip