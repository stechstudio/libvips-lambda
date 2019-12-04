#!/bin/sh

fetchSource pcre https://downloads.sourceforge.net/project/pcre/pcre/${VERSION_PCRE}/pcre-${VERSION_PCRE}.tar.bz2
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_PCRE}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure  \
        --prefix=${TARGET} \
        --docdir=${TARGET}/share/doc/pcre-8.40 \
        --enable-unicode-properties       \
        --enable-pcre16                   \
        --enable-pcre32                   \
        --enable-pcregrep-libz            \
        --disable-static >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install    >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi