#!/bin/sh


fetchSource pixman http://cairographics.org/releases/pixman-${VERSION_PIXMAN}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-arm-iwmmxt > config.log
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