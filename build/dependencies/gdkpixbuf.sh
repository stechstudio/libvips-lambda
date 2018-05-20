#!/bin/sh

fetchSource gdkpixbuf https://download.gnome.org/sources/gdk-pixbuf/2.36/gdk-pixbuf-${VERSION_GDKPIXBUF}.tar.xz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_GDKPIXBUF}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
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
        --with-included-loaders=png,jpeg  >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install-strip   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi