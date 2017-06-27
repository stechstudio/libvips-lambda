#!/bin/sh
set -e

fetchSource php https://github.com/php/php-src/archive/php-${VERSION_PHP}.tar.gz

# Build PHP
./buildconf --force
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
--with-libxml-dir=${TARGET}
make
make install
cp php.ini-production ${TARGET}/lib/php.ini