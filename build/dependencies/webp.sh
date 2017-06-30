#!/bin/sh


fetchSource webp http://downloads.webmproject.org/releases/webp/libwebp-${VERSION_WEBP}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-neon \
        --enable-libwebpmux \
        --with-pngincludedir=${TARGET}/include \
        --with-pnglibdir=${TARGET}/lib > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install-strip   > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi