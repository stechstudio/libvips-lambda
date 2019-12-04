#!/bin/sh

fetchSource swig http://downloads.sourceforge.net/swig/swig-${VERSION_SWIG}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_SWIG}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure \
        --prefix=${TARGET} \
        --with-pcre-prefix=${TARGET} \
        --without-alllang   \
        --with-python=/usr/bin/python \
        --without-maximum-compile-warnings >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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