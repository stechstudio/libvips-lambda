#!/bin/sh \


fetchSource expat http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/expat/expat/${VERSION_EXPAT}/expat-${VERSION_EXPAT}.tar.bz2

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install   > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi