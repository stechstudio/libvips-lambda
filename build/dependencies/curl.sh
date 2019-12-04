#!/bin/sh

fetchSource curl https://github.com/curl/curl/archive/curl-${VERSION_CURL//./_}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_CURL}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    LD_LIBRARY_PATH=${TARGET}/lib \
        ./buildconf >> ${BUILD_LOGS}/${DEP_NAME}.buildconfig.log 2>&1

    LD_LIBRARY_PATH=${TARGET}/lib \
    ./configure \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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
    touch made.sts
else
	printf "\tAlready Built\n"
fi