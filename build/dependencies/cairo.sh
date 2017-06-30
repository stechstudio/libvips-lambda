#!/bin/sh \

fetchSource cairo http://cairographics.org/releases/cairo-${VERSION_CAIRO}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-xlib \
        --disable-xcb \
        --disable-quartz \
        --disable-win32 \
        --disable-egl \
        --disable-glx \
        --disable-wgl \
        --disable-script \
        --disable-ps \
        --disable-gobject \
        --disable-trace \
        --disable-interpreter > config.log
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