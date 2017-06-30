#!/bin/sh \


fetchSource swig http://downloads.sourceforge.net/swig/swig-${VERSION_SWIG}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure \
        --prefix=${TARGET} \
        --with-pcre-prefix=${TARGET} \
        --without-alllang   \
        --with-python=/usr/bin/python \
        --without-maximum-compile-warnings > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make
    make install   > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi