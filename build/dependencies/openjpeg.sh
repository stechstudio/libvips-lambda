#!/bin/sh


fetchSource openjpeg https://github.com/uclouvain/openjpeg/archive/v${VERSION_OPENJPEG}.tar.gz

mkdir -p build
cd build

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${TARGET} \
        -DBUILD_SHARED_LIBS:bool=on \
        -DCMAKE_LIBRARY_PATH=${TARGET}/lib   \
        -DCMAKE_C_FLAGS="${FLAGS}" > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi

if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install  > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi