#!/bin/sh \


fetchSource curl https://github.com/curl/curl/archive/curl-${VERSION_CURL//./_}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    LD_LIBRARY_PATH=${TARGET}/lib \
        ./buildconf

    LD_LIBRARY_PATH=${TARGET}/lib \
    ./configure \
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
    make install   > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi