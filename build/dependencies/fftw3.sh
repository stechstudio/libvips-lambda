#!/bin/sh


fetchSource fftw3 http://www.fftw.org/fftw-${VERSION_FFTW3}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-threads \
        --enable-shared > config.log
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