#!/bin/sh \


fetchSource ffi ftp://sourceware.org/pub/libffi/libffi-${VERSION_FFI}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure \
        --host=${CHOST} \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-builddir > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install-strip    > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi