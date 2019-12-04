#!/bin/sh

fetchSource openjpeg https://github.com/uclouvain/openjpeg/archive/v${VERSION_OPENJPEG}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_OPENJPEG}\""

mkdir -p build
cd build

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${TARGET} \
        -DBUILD_SHARED_LIBS:bool=on \
        -DCMAKE_LIBRARY_PATH=${TARGET}/lib   \
        -DCMAKE_C_FLAGS="${FLAGS}" >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
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