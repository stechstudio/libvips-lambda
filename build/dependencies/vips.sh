#!/bin/sh

fetchSource vips https://github.com/libvips/libvips/releases/download/v${VERSION_VIPS}/vips-${VERSION_VIPS}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_VIPS}\""

if [ ! -f "patched.sts" ]; then
    printf "\tPatching\n"
    curl -o libvips/foreign/pdfload.c https://raw.githubusercontent.com/jcupitt/libvips/61d5ba7b58af0bbd51ef26fa875713a0014e457b/libvips/foreign/pdfload.c   >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch patched.sts
else
    printf "\tAlready Patched\n"
fi


if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-debug \
        --disable-introspection \
        --with-zlib-includes=${TARGET}/include \
        --with-zlib-libraries=${TARGET}/lib \
        --with-jpeg-includes=${TARGET}/include \
        --with-jpeg-libraries=${TARGET}/lib \
        --with-png-includes=${TARGET}/include \
        --with-png-libraries=${TARGET}/lib \
        --with-giflib-includes=${TARGET}/include \
        --with-giflib-libraries=${TARGET}/lib \
        --with-tiff-includes=${TARGET}/include \
        --with-tiff-libraries=${TARGET}/lib \
        --with-libwebp-includes=${TARGET}/include \
        --with-libwebp-libraries=${TARGET}/lib  >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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