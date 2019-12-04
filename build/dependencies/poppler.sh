#!/bin/sh

fetchSource poppler https://poppler.freedesktop.org/poppler-${VERSION_POPPLER}.tar.xz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_POPPLER}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
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
        --with-font-configuration=fontconfig >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi

if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    {
        make
        make install
    } >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi