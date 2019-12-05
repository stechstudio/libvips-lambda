#!/bin/sh

fetchSource php https://github.com/php/php-src/archive/php-${VERSION_PHP}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_PHP}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./buildconf --force >> ${BUILD_LOGS}/${DEP_NAME}.buildconfig.log 2>&1
    LD_LIBRARY_PATH=${TARGET}/lib \
        ./configure \
        --prefix=${TARGET} \
        --with-config-file-path=${TARGET}/etc/php \
        --with-config-file-scan-dir=${TARGET}/modules \
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
        --with-jpeg-dir=${TARGET}    >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    {
        make
        make install
    } >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    mkdir -p ${TARGET}/etc/php
    cp php.ini-production ${TARGET}/etc/php/php.ini
    touch made.sts
else
	printf "\tAlready Built\n"
fi
