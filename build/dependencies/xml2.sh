#!/bin/sh


fetchSource xml2 http://xmlsoft.org/sources/libxml2-${VERSION_XML2}.tar.gz
if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
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
        --with-zlib=${TARGET} > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install    > make.log
    cp xml2-config /target/bin/xml2-config
    touch made.sts
else
	echo "\tAlready Built"
fi