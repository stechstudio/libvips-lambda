#!/bin/sh \


fetchSource imagemagick ftp://ftp.osuosl.org/pub/blfs/conglomeration/ImageMagick/ImageMagick-${VERSION_IMAGEMAGICK}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure \
        --prefix=${TARGET} \
        --sysconfdir=${TARGET}/etc \
        --enable-hdri     \
        --with-gslib    \
        --with-rsvg     \
        --disable-static > config.log
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