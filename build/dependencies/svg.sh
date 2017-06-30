#!/bin/sh


fetchSource svg https://download.gnome.org/sources/librsvg/2.40/librsvg-${VERSION_SVG}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-tools \
        --disable-pixbuf-loader > config.log
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