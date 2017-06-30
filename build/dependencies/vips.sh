#!/bin/sh


fetchSource vips https://github.com/jcupitt/libvips/releases/download/v${VERSION_VIPS}/vips-${VERSION_VIPS}.tar.gz

if [ ! -f "patched.sts" ]; then
    curl -o libvips/foreign/pdfload.c https://raw.githubusercontent.com/jcupitt/libvips/61d5ba7b58af0bbd51ef26fa875713a0014e457b/libvips/foreign/pdfload.c
    touch patched.sts
else
    echo "Already Patched"
fi


if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
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
        --with-libwebp-libraries=${TARGET}/lib  > config.log
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