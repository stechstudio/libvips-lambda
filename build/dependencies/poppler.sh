#!/bin/sh


fetchSource poppler https://poppler.freedesktop.org/poppler-${VERSION_POPPLER}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET}  \
        --disable-dependency-tracking \
        --enable-shared \
        --disable-static \
        --enable-xpdf-headers  \
        --enable-build-type=release \
        --enable-cmyk \
        --enable-libopenjpeg=openjpeg2 \
        --disable-libnss \
        --enable-libcurl \
        --disable-poppler-qt4  \
        --disable-poppler-qt5   \
        --disable-poppler-cpp   \
        --sysconfdir=${TARGET}/etc   \
        --with-font-configuration=fontconfig > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make
    make install  > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi