#!/bin/sh \


fetchSource glib https://download.gnome.org/sources/glib/2.52/glib-${VERSION_GLIB}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"

    echo glib_cv_stack_grows=no >>glib.cache
    echo glib_cv_uscore=no >>glib.cache

    ./configure \
        --cache-file=glib.cache  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-pcre=system  > config.log
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