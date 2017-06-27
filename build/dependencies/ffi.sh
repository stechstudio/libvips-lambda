#!/bin/sh \
set -e

fetchSource ffi ftp://sourceware.org/pub/libffi/libffi-${VERSION_FFI}.tar.gz

if [ ! -f "Makefile" ]; then
    ./configure \
        --host=${CHOST} \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-builddir
else
    echo "Already Configured"
fi

make install-strip