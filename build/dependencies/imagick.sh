#!/bin/sh

fetchSource imagick https://github.com/mkoppanen/imagick/archive/${VERSION_IMAGICK}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_IMAGICK}\""

if [ ! -f "Makefile" ]; then

    ${TARGET}/bin/phpize
    ./configure \
        --with-php-config=${TARGET}/bin/php-config  \
         --with-libdir=${TARGET}/lib \
         --with-imagick=${TARGET} >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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
    cp rpm/imagick.ini ${TARGET}/modules/imagick.ini
    touch made.sts
else
	printf "\tAlready Built\n"
fi
