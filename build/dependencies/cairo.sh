#!/bin/sh \
set -e

fetchSource cairo http://cairographics.org/releases/cairo-${VERSION_CAIRO}.tar.xz

if [ ! -f "Makefile" ]; then
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
        --disable-interpreter
else
    echo "Already Configured"
fi

make install-strip