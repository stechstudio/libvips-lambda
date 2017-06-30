#!/bin/sh \


fetchSource harfbuzz https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${VERSION_HARFBUZZ}.tar.bz2

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
    touch made.sts
else
	echo "\tAlready Built"
fi