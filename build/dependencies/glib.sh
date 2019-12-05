#!/bin/sh

fetchSource glib \
    https://download.gnome.org/sources/glib/$(
    echo ${VERSION_GLIB} | cut -d '.' -f 1-2
    )/glib-${VERSION_GLIB}.tar.xz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_GLIB}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"

    echo glib_cv_stack_grows=no >>glib.cache
    echo glib_cv_uscore=no >>glib.cache

    ./configure \
        --cache-file=glib.cache  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-pcre=system  >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    {
        make
        make install-strip
    } >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi