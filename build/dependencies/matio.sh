#!/bin/sh


fetchSource matio https://github.com/tbeu/matio/releases/download/v${VERSION_MATIO}/matio-${VERSION_MATIO}.tar.gz
if [ ! -f "Makefile" ]; then
    ./autogen.sh
    ./configure  \
        --prefix=${TARGET}  \
         --enable-shared \
         --disable-static \
else
    echo "\tAlready Configured"
fi
make install-strip