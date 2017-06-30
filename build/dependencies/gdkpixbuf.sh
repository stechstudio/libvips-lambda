#!/bin/sh


fetchSource gdkpixbuf https://download.gnome.org/sources/gdk-pixbuf/2.36/gdk-pixbuf-${VERSION_GDKPIXBUF}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    touch gdk-pixbuf/loaders.cache
    LD_LIBRARY_PATH=${TARGET}/lib \
        ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-modules \
        --disable-gio-sniffing \
        --without-libtiff \
        --without-gdiplus \
        --with-included-loaders=png,jpeg  > config.log
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