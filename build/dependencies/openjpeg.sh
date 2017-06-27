#!/bin/sh
set -e

fetchSource openjpeg https://github.com/uclouvain/openjpeg/archive/v${VERSION_OPENJPEG}.tar.gz

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${TARGET} -DBUILD_SHARED_LIBS:bool=on -DCMAKE_C_FLAGS="${FLAGS}"

make install