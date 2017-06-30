#!/bin/sh

fetchSource xml2 http://xmlsoft.org/sources/libxml2-${VERSION_XML2}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_XML2}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure  \
        --prefix=${TARGET} \
        --exec-prefix=${TARGET} \
        --with-sysroot=${TARGET} \
        --enable-shared \
        --disable-static \
        --with-html \
        --with-history \
        --enable-ipv6=no \
        --with-icu \
        --with-zlib=${TARGET} >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install    >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    cp xml2-config ${TARGET}/bin/xml2-config
    touch made.sts
else
	printf "\tAlready Built\n"
fi