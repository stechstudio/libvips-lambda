#!/bin/sh \
set -e

fetchSource harfbuzz https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${VERSION_HARFBUZZ}.tar.bz2
if [ ! -f "Makefile" ]; then
    ./configure  \
    --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking
else
    echo "Already Configured"
fi
make install-strip