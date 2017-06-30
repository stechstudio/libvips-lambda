#!/bin/sh

fetchSource cairo http://cairographics.org/releases/cairo-${VERSION_CAIRO}.tar.xz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_CAIRO}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
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
        --disable-interpreter >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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