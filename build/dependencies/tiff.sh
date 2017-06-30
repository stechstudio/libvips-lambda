#!/bin/sh \


fetchSource tiff http://download.osgeo.org/libtiff/tiff-${VERSION_TIFF}.tar.gz

if [ ! -f "patched.sts" ]; then
    # Apply patches for libtiff vulnerabilities reported since last version
    VERSION_TIFF_GIT_MASTER_SHA=$(curl -Ls https://api.github.com/repos/vadz/libtiff/git/refs/heads/master | jq -r '.object.sha' | head -c7)
    curl -Ls https://github.com/vadz/libtiff/compare/Release-v${VERSION_TIFF//./-}...master.patch | patch -p1 -t || true
    touch patched.sts
else
    echo "Already Patched"
fi

if [ ! -f "configured.sts" ]; then
    echo "\tConfiguring"
    autoreconf -fiv
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking \
        --with-sysroot=${TARGET}  \
        --disable-mdi \
        --disable-pixarlog \
        --disable-cxx > config.log
    touch configured.sts
else
    echo "\tAlready Configured"
fi
if [ ! -f "made.sts" ]; then
    echo "\tBuilding"
    make install-strip   > make.log
    touch made.sts
else
	echo "\tAlready Built"
fi