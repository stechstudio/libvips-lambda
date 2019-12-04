#!/bin/sh

fetchSource phpvips https://github.com/jcupitt/php-vips-ext/raw/master/vips-${VERSION_EXT_VIPS_PHP}.tgz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_EXT_VIPS_PHP}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ${TARGET}/bin/phpize ${BUILD_LOGS}/${DEP_NAME}.phpize.log 2>&1
    ./configure \
        --with-php-config=${TARGET}/bin/php-config \
        --with-libdir=${TARGET}/lib \
        --with-vips >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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
    mkdir -p ${TARGET}/modules
    echo "extension=vips.so" > ${TARGET}/modules/ext-phpvips.ini
    touch made.sts
else
	printf "\tAlready Built\n"
fi

