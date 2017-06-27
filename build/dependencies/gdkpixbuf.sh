#!/bin/sh
set -e

fetchSource gdkpixbuf https://download.gnome.org/sources/gdk-pixbuf/2.36/gdk-pixbuf-${VERSION_GDKPIXBUF}.tar.xz

if [ ! -f "Makefile" ]; then
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
        --with-included-loaders=png,jpeg
else
    echo "Already Configured"
fi

make install-strip
