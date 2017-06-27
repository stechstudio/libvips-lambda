#!/bin/sh
set -e

pushd `dirname $0` > /dev/null
BUILDPATH=`pwd`
popd > /dev/null


# Exports and Versions
source "${BUILDPATH}/exports.sh"
source "${BUILDPATH}/versions.sh"

# Pull in our Functions
source "${BUILDPATH}/functions.sh"

# Build All Dependencies
build zlib
build ffi
build glib
build xml2
build xlst
build gsf
build exif
build lcms2
build jpeg
build png16
build webp
build tiff
build orc
build gdkpixbuf
build freetype
build expat
build fontconfig
build harfbuzz
build pixman
build cairo
build pango
build croco
build svg
build gif
build curl
build openjpeg
build poppler

#build matio

# Now we can build vips
build vips

if [[ "${BUILD_PHP}" == "YES" ]]; then
    build php
    build phpvips
fi

# Remove the old C++ bindings
cd ${TARGET}/include
rm -rf vips/vipsc++.h vips/vipscpp.h
cd ${TARGET}/lib
rm -rf .libs *.la libvipsCC*

# Create JSON file of version numbers
toJson

# Create .tar.gz
packageVips
