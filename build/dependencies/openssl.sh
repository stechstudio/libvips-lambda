#!/bin/sh


fetchSource openssl https://openssl.org/source/openssl-${VERSION_OPENSSL}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    mkdir -p ${TARGET}/etc/ssl
    sed -i 's# libcrypto.a##;s# libssl.a##' Makefile
    ./config  \
        --prefix=${TARGET}  \
         --openssldir=${TARGET}/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install   > make.log
    curl -o ${TARGET}/etc/ssl/certdata.txt https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt
    touch made.sts
else
	echo "\tAlready Built"
fi