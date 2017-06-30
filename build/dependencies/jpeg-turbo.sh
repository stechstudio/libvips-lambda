#!/bin/sh \


fetchSource jpeg-turbo http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-${VERSION_JPGTURBO}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-jpeg8 \
        --without-simd \
        --without-turbojpeg  > config.log
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