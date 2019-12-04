#!/bin/sh

fetchSource openssl https://openssl.org/source/openssl-${VERSION_OPENSSL}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_OPENSSL}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    mkdir -p ${TARGET}/etc/ssl
    sed -i 's# libcrypto.a##;s# libssl.a##' Makefile
    ./config  \
        --prefix=${TARGET}  \
         --openssldir=${TARGET}/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    (
        # OpenSSL doesn't build reliably with multiple jobs.
        unset MAKEFLAGS
        make
        echo -e "\make install\n"
        make install
        curl -o ${TARGET}/etc/ssl/certdata.txt \
            https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt
    ) >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi