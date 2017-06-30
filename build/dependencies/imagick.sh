#!/bin/sh \


fetchSource imagick https://github.com/mkoppanen/imagick/archive/${VERSION_IMAGICK}.tar.gz

if [ ! -f "Makefile" ]; then

    ${TARGET}/bin/phpize
    ./configure \
        --with-php-config=${TARGET}/bin/php-config  \
         --with-libdir=${TARGET}/lib \
         --with-imagick=${TARGET} > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install
    mkdir -p ${TARGET}/modules
    cp rpm/imagick.ini ${TARGET}/modules/imagick.ini
    touch made.sts
else
	echo "\tAlready Built"
fi
