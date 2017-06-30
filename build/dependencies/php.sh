#!/bin/sh


fetchSource php https://github.com/php/php-src/archive/php-${VERSION_PHP}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./buildconf --force
    LD_LIBRARY_PATH=${TARGET}/lib \
        ./configure \
        --prefix=${TARGET} \
        --with-config-file-path=/var/task/lib \
        --with-config-file-scan-dir=/var/task/modules \
        \
        --enable-bcmath \
        --enable-calendar \
        --enable-ctype \
        --enable-exif \
        --enable-ftp \
        --enable-gd-jis-conv \
        --enable-gd-native-ttf \
        --enable-json \
        --enable-mbstring \
        --enable-pcntl \
        --enable-pdo \
        --enable-shared=yes \
        --enable-static=no \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-zip \
        \
        --with-curl=${TARGET} \
        --with-gd \
        --with-gmp \
        --with-iconv \
        --with-mysqli=mysqlnd \
        --with-openssl \
        --with-pdo-mysql=mysqlnd \
        --with-zlib \
        --with-libxml-dir=${TARGET}  \
        --with-webp-dir=${TARGET}  \
        --with-png-dir=${TARGET}  \
        --with-jpeg-dir=${TARGET}    > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make
    make install
    cp php.ini-production ${TARGET}/lib/php.ini
    touch made.sts
else
	echo "\tAlready Built"
fi
