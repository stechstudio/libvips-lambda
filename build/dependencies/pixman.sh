#!/bin/sh

fetchSource pixman http://cairographics.org/releases/pixman-${VERSION_PIXMAN}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_PIXMAN}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure  \
        --prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --disable-arm-iwmmxt >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install-strip   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi