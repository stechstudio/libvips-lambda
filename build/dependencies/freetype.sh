#!/bin/sh \


fetchSource freetype http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/freetype/freetype2/${VERSION_FREETYPE}/freetype-${VERSION_FREETYPE}.tar.gz

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
