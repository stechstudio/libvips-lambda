#!/bin/sh


fetchSource orc http://gstreamer.freedesktop.org/data/src/orc/orc-${VERSION_ORC}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install-strip   > make.log
    cd ${TARGET}/lib
    rm -rf liborc-test-*
    cd -
    touch made.sts
else
	echo "\tAlready Built"
fi
