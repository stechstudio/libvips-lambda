#!/bin/sh \
set -e

fetchSource glib https://download.gnome.org/sources/glib/2.52/glib-${VERSION_GLIB}.tar.xz

if [ ! -f "Makefile" ]; then

    echo glib_cv_stack_grows=no >>glib.cache
    echo glib_cv_uscore=no >>glib.cache

    ./configure \
        --cache-file=glib.cache  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-pcre=internal \
        --disable-libmount
else
    echo "Already Configured"
fi

make install-strip