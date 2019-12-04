#!/bin/sh

fetchSource imagemagick ftp://ftp.osuosl.org/pub/blfs/conglomeration/ImageMagick/ImageMagick-${VERSION_IMAGEMAGICK}.tar.xz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_IMAGEMAGIC}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure \
        --prefix=${TARGET} \
        --sysconfdir=${TARGET}/etc \
        --enable-hdri     \
        --with-gslib    \
        --with-rsvg     \
        --disable-static >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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