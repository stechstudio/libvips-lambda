#!/bin/sh


fetchSource phpvips https://github.com/jcupitt/php-vips-ext/raw/master/vips-${VERSION_EXT_VIPS_PHP}.tgz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ${TARGET}/bin/phpize
    ./configure \
        --with-php-config=/target/bin/php-config \
        --with-libdir=${TARGET}/lib \
        --with-vips > config.log
        touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install
    mkdir -p ${TARGET}/modules
    echo "extension=vips.so" > ${TARGET}/modules/ext-phpvips.ini
    touch made.sts
else
	echo "\tAlready Built"
fi

