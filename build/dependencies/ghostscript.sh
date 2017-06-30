#!/bin/sh


fetchSource ghostscript https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs921/ghostscript-${VERSION_GHOSTSCRIPT}.tar.gz

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    rm -rf freetype lcms2 jpeg libpng

    ./configure  \
        --prefix=${TARGET} \
        --disable-compile-inits \
        --enable-dynamic        \
         --with-drivers=FILES \
        --with-system-libtiff > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make so
    make install
    make soinstall
    install -v -m644 base/*.h ${TARGET}/include/ghostscript

    mkdir -p /target/share/ghostscript
    curl -Ls http://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz | tar xzC ${TARGET}/share/ghostscript
    curl -Ls http://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz | tar xzC ${TARGET}/share/ghostscript
    ${TARGET}/bin/fc-cache -v ${TARGET}/share/ghostscript/fonts/

    touch made.sts
else
	echo "\tAlready Built"
fi

