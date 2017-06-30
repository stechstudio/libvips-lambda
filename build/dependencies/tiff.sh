#!/bin/sh

fetchSource tiff http://download.osgeo.org/libtiff/tiff-${VERSION_TIFF}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_TIFF}\""

if [ ! -f "patched.sts" ]; then
    printf "\tPatching\n"
    # Apply patches for libtiff vulnerabilities reported since last version
    VERSION_TIFF_GIT_MASTER_SHA=$(curl -Ls https://api.github.com/repos/vadz/libtiff/git/refs/heads/master | jq -r '.object.sha' | head -c7)
    curl -Ls https://github.com/vadz/libtiff/compare/Release-v${VERSION_TIFF//./-}...master.patch | patch -p1 -t  >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1 || true
    touch patched.sts
else
    printf "\tAlready Patched\n"
fi

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    autoreconf -fiv
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-sysroot=${TARGET}  \
        --disable-mdi \
        --disable-pixarlog \
        --disable-cxx >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    make install-strip   >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi