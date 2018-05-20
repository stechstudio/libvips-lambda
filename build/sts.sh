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

rm -rf ${BUILD_LOGS}/*

# Build All Dependencies

########################################################################################################################
#
# These have no dependencies to worry about
#
########################################################################################################################

# http://www.linuxfromscratch.org/lfs/view/development/chapter06/zlib.html
# Dependencies:
#   - None
# Depended on by:
## build zlib

# http://www.linuxfromscratch.org/blfs/view/svn/general/pcre.html
# Dependencies:
#   - None
# Depended on by:
#   - php
build pcre

# http://www.linuxfromscratch.org/blfs/view/svn/general/libffi.html
# Dependencies:
#   - None
# Depended on by:
#   - GLib
build ffi

# http://www.linuxfromscratch.org/blfs/view/svn/general/libpng.html
# Dependencies:
#   - None
# Depended on by:
#   - gdk-pixbuf
#   - pixman
#   - cairo
#   - openjpeg
#   - poppler
#   - php
#   - ghostscript
build png16

# http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
# Dependencies:
#   - None
# Depended on by:
#   - libjpeg-turbo
build nasm

# http://www.linuxfromscratch.org/blfs/view/svn/general/libexif.html
# Dependencies:
#   - None
# Depended on by:
#   - php
## build exif

# http://www.linuxfromscratch.org/blfs/view/8.0/general/giflib.html
# Dependencies:
#   - None
# Depended on by:
#   - libwebp
build gif

# https://gstreamer.freedesktop.org/projects/orc.html
# Dependencies:
#   - None
# Depended on by:
## build orc

# http://www.linuxfromscratch.org/blfs/view/svn/general/icu.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
## build icu

# http://www.linuxfromscratch.org/blfs/view/7.5/general/expat.html
# Dependencies:
#   - None
# Depended on by:
build expat

# http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# Dependencies:
#   - None
# Depended on by:
#   - curl
#   - php
## build openssl

# http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
# Dependencies:
#   - None
# Depended on by:
#   - vips
## build fftw3


########################################################################################################################
#
# These have dependencies trees to satisfy
#
########################################################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/general/libxml2.html
# Dependencies:
#   - zlib
#   - icu
# Depended on by:
#   - libxslt
#   - libgsf
#   - fontconfig
#   - croco
#   - php
build xml2

# http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
# Dependencies:
#   - pcre
# Depended on by:
#   - vips
## build swig

# http://www.linuxfromscratch.org/blfs/view/svn/general/pixman.html
# Dependencies:
#   - LibPNG
# Depended on by:
#   - Cairo
## build pixman

# http://www.linuxfromscratch.org/blfs/view/svn/general/libjpeg.html
# Dependencies:
#   - nasm
# Depended on by:
#   - gdk-pixbuf
#   - lcms2
#   - poppler
#   - php
#   - ghostscript
build jpeg-turbo

# http://www.linuxfromscratch.org/blfs/view/cvs/general/libtiff.html
# Dependencies:
#   - libjpeg-turbo
# Depended on by:
#   - lcms2
#   - openjpeg
#   - poppler
#   - php
#   - ghostscript
build tiff

# http://www.linuxfromscratch.org/blfs/view/cvs/general/libxslt.html
# Dependencies:
#   - libxml2
# Depended on by:
#   - php
## build xlst

# http://www.linuxfromscratch.org/blfs/view/cvs/general/glib2.html
# Dependencies:
#   - libffi
#   - Python
# Depended on by:
#   - libgsf
#   - gdk-pixbuf
#   - HarfBuzz
#   - Cairo
#   - croco
build glib

# http://www.linuxfromscratch.org/blfs/view/svn/x/gdk-pixbuf.html
# Dependencies:
#   - GLib
#   - libjpeg-turbo
#   - libpng
# Depended on by:
#   - libsrvg
## build gdkpixbuf

# http://www.linuxfromscratch.org/blfs/view/svn/general/libgsf.html
# Dependencies:
#   - GLib
#   - libxml2
#   - gdk-pixbuf
# Depended on by:
build gsf

# http://www.linuxfromscratch.org/blfs/view/cvs/general/lcms2.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
# Depended on by:
#   - openjpeg
#   - poppler
#   - ghostscript
build lcms2

# http://www.linuxfromscratch.org/blfs/view/8.0/general/libwebp.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
#   - libpng
#   - giflib
# Depended on by:
## build webp

########################################################################################################################
#
#   HarfBuzz wants freetype before it is installed, and freetype wants harfbuz after it is installed. So we do this.
#
########################################################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
## build freetype

# http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# Dependencies:
#   - Freetype
#   - libxml
# Depended on by:
#   - harfbuzz
#   - Cairo
## build fontconfig

# http://www.linuxfromscratch.org/blfs/view/8.0/x/cairo.html
# Dependencies:
#   - libpng
#   - pixman
#   - fontconfig
#   - glib
# Depended on by:
#   - harfbuzz
#   - pango
#   - poppler
#   - ghostscript
## build cairo

# http://www.linuxfromscratch.org/blfs/view/svn/general/harfbuzz.html
# Dependencies:
#   - Freetype
# Depended on by:
#   - Freetype
## build harfbuzz

# http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# Dependencies:
#   - HarfBuzz
# Depended on by:
#   - fontconfig
#   - php
#   - ghostscript
## rm -rf ${DEPS}/freetype
## build freetype

# http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# Dependencies:
#   - Freetype
#   - libxml
# Depended on by:
#   - pango
#   - poppler
#   - ghostscript
## rm -rf ${DEPS}/fontconfig
## build fontconfig

########################################################################################################################
#
#   Stupid freetype harfbuzz
#
########################################################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/x/pango.html
# Dependencies:
#   - FontConfig
#   - Cairo
# Depended on by:
#   - libsrvg
## build pango

# http://www.linuxfromscratch.org/blfs/view/svn/general/libcroco.html
# Dependencies:
#   - GLib
#   - libxml
# Depended on by:
#   - libsrvg
## build croco

# http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# Dependencies:
#   - gdk-pixbuf
#   - croco
#   - pango
# Depended on by:
## build svg

# http://www.linuxfromscratch.org/blfs/view/8.0/basicnet/curl.html
# Dependencies:
#   - OpenSSL
# Depended on by:
#   - poppler
#   - php
## build curl

# http://www.linuxfromscratch.org/blfs/view/svn/general/openjpeg.html
# Dependencies:
#   - LCMS
#   - libpng
#   - libtiff
# Depended on by:
#   - poppler
## build openjpeg

# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - fontconfig
#   - Cairo
#   - libjpeg
#   - libpng
#   - openjpeg
# Depended on by:
#   - vips
## build poppler

# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - freetype
#   - libjpeg
#   - libpng
#   - libtiff
#   - lcms2
#   - cairo
#   - fontconfig
# Depended on by:
#   -
build ghostscript

# http://www.linuxfromscratch.org/blfs/view/cvs/general/imagemagick.html
# Dependencies:
#   - curl
#   - fttw3
#   - lcms2
#   - libexif
#   - libjpeg-turbo
#   - libpng
#   - librsvg
#   - libtiff
#   - libwebp
#   - openjpeg
#   - pango
#   - ghostscript
# Depended on by:
#   - vips
## build imagemagick


# https://github.com/jcupitt/libvips
# Dependencies:
#   - libjpeg
#   - libexif
#   - giflib
#   - librsvg
#   - libpoppler
#   - libgsf-1
#   - libtiff
#   - fftw3
#   - lcms2
#   - libpng
#   - ImageMagick
#   - pango
#   - orc
#   - libwebp
#   - swig
# Depended on by:
#   - phpvips
build vips

# http://www.linuxfromscratch.org/blfs/view/svn/general/php.html
# Dependencies:
#   - libxml2
#   - libxslt
#   - pcre
#   - freetype
#   - libexif
#   - libjpeg-turbo
#   - libpng
#   - libtiff
#   - curl
#   - openssl
# Depended on by:
#   - phpvips
build php

# https://github.com/jcupitt/php-vips-ext
# Dependencies:
#   - vips
#   - php
# Depended on by:
#   - none
build phpvips

# Remove the old C++ bindings
cd ${TARGET}/include
rm -rf vips/vipsc++.h vips/vipscpp.h
cd ${TARGET}/lib
rm -rf .libs *.la libvipsCC*

# Create JSON file of version numbers
toJson

# Create .tar.gz
packageVips
