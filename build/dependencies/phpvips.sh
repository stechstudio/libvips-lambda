#!/bin/sh
set -e

fetchSource phpvips https://github.com/jcupitt/php-vips-ext/raw/master/vips-1.0.7.tgz

# Build PHP extension
${TARGET}/bin/phpize
./configure \
    --with-php-config=/target/bin/php-config \
    --with-libdir=${TARGET}/lib \
    --with-vips
make install
mkdir -p ${TARGET}/modules
echo "extension=vips.so" > ${TARGET}/modules/ext-phpvips.ini
