#!/bin/sh
set -e

# Default Version Numbers
if [ -z ${VERSION_VIPS+x} ]; then
    export VERSION_VIPS=8.5.6
fi

if [ -z ${VERSION_PHP+x} ]; then
    export VERSION_PHP=7.1.6
fi

# Dependency version numbers
export VERSION_ZLIB=1.2.11
export VERSION_FFI=3.2.1
export VERSION_GLIB=2.52.0
export VERSION_XML2=2.9.4
export VERSION_GSF=1.14.41
export VERSION_EXIF=0.6.21
export VERSION_LCMS2=2.8
export VERSION_JPEG=1.5.1
export VERSION_PNG16=1.6.28
export VERSION_WEBP=0.6.0
export VERSION_TIFF=4.0.7
export VERSION_ORC=0.4.26
export VERSION_GDKPIXBUF=2.36.6
export VERSION_FREETYPE=2.7.1
export VERSION_EXPAT=2.2.0
export VERSION_FONTCONFIG=2.12.1
export VERSION_HARFBUZZ=1.4.5
export VERSION_PIXMAN=0.34.0
export VERSION_CAIRO=1.14.8
export VERSION_PANGO=1.40.4
export VERSION_CROCO=0.6.11
export VERSION_SVG=2.40.16
export VERSION_GIF=5.1.4
export VERSION_CURL=7.54.0
export VERSION_POPPLER=0.56.0
export VERSION_MATIO=1.5.10
export VERSION_OPENJPEG=2.1.2
export VERSION_PHPVIPS=1.0.7
export VERSION_XLST=1.1.29

# Least out-of-sync Sourceforge mirror
export SOURCEFORGE_MIRROR=netix