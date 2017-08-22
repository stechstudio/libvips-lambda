#!/bin/sh

fetchSource icu http://download.icu-project.org/files/icu4c/${VERSION_ICU}/icu4c-59_1-src.tgz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_ICU}\""

cd source
if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --with-library-bits=64 \
        --with-data-packaging=library \
        --enable-tests=no \
        --enable-samples=no \
        --disable-static >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi