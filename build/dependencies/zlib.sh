#!/bin/sh \


fetchSource zlib http://zlib.net/zlib-${VERSION_ZLIB}.tar.xz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure \
        --prefix=${TARGET} \
        --uname=linux > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install    > make.log
    rm ${TARGET}/lib/libz.a
    touch made.sts
else
	echo "\tAlready Built"
fi