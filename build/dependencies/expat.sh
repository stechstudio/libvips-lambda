#!/bin/sh \
set -e

fetchSource expat http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/expat/expat/${VERSION_EXPAT}/expat-${VERSION_EXPAT}.tar.bz2
if [ ! -f "Makefile" ]; then
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static
else
    echo "Already Configured"
fi
make install