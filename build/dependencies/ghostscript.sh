#!/bin/sh

#fetchSource ghostscript https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs926/ghostscript-${VERSION_GHOSTSCRIPT}.tar.gz

export DEP_NAME=ghostscript
build_dir=${DEPS}/${DEP_NAME}
git clone http://git.ghostscript.com/ghostpdl.git ${build_dir}
cd ${build_dir}
VERSION_GHOSTSCRIPT=$(git rev-parse --short HEAD)

export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_GHOSTSCRIPT}\""

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    rm -rf freetype lcms2 jpeg libpng

    ./autogen.sh  \
        --prefix=${TARGET} \
        --disable-compile-inits \
        --enable-dynamic        \
         --with-drivers=FILES \
        --with-system-libtiff >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi

if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    mkdir -p ${TARGET}/include/ghostscript
    install -v -m644 base/*.h ${TARGET}/include/ghostscript   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1

    mkdir -p ${TARGET}/share/ghostscript
    curl -Ls http://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz | tar xzC ${TARGET}/share/ghostscript   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    curl -Ls http://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz | tar xzC ${TARGET}/share/ghostscript   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    /usr/bin/fc-cache -v ${TARGET}/share/ghostscript/fonts/  >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1

    touch made.sts
else
	printf "\tAlready Built\n"
fi

