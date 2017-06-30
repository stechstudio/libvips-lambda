#!/bin/sh


fetchSource icu http://download.icu-project.org/files/icu4c/${VERSION_ICU}/icu4c-59_1-src.tgz
cd source
if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --with-library-bits=64 \
        --with-data-packaging=library \
        --enable-tests=no \
        --enable-samples=no \
        --disable-static > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install   > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi