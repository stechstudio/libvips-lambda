#!/bin/sh

# Default Version Numbers
if [ -z ${VERSION_VIPS+x} ]; then
    export VERSION_VIPS=8.5.6       # https://github.com/jcupitt/libvips/releases
fi

if [ -z ${VERSION_PHP+x} ]; then
    export VERSION_PHP=7.1.6        # https://github.com/php/php-src/releases
fi

if [ -z ${BUILD_PHP+x} ]; then
    export BUILD_PHP=NO
fi

# Dependency version numbers
export VERSION_CAIRO=1.14.10        # https://www.cairographics.org/releases/
export VERSION_CROCO=0.6.12         # https://github.com/GNOME/libcroco/releases
export VERSION_CURL=7.54.1          # https://github.com/curl/curl/releases
export VERSION_EXIF=0.6.21          # https://sourceforge.net/projects/libexif/files/libexif/
export VERSION_EXPAT=2.2.1          # https://sourceforge.net/projects/expat/files/expat/
export VERSION_FFI=3.2.1            # https://github.com/libffi/libffi/releases
export VERSION_FFTW3=3.3.6-pl2      # http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
export VERSION_FONTCONFIG=2.12.1    # https://www.freedesktop.org/wiki/Software/fontconfig/
export VERSION_FREETYPE=2.8         # https://sourceforge.net/projects/freetype/files/freetype2/
export VERSION_GDKPIXBUF=2.36.6     # https://github.com/GNOME/gdk-pixbuf/releases
export VERSION_GIF=5.1.4            # https://sourceforge.net/projects/giflib/files/?source=navbar
export VERSION_GLIB=2.52.0          # https://github.com/GNOME/glib/releases
export VERSION_GHOSTSCRIPT=9.26     # http://www.linuxfromscratch.org/blfs/view/cvs/pst/gs.html
export VERSION_GSF=1.14.41          # https://github.com/GNOME/libgsf/releases
export VERSION_HARFBUZZ=1.4.5       # https://github.com/behdad/harfbuzz/releases
export VERSION_ICU=59.1             # http://www.linuxfromscratch.org/blfs/view/svn/general/icu.html
export VERSION_IMAGEMAGICK=7.0.4-8  # http://www.linuxfromscratch.org/blfs/view/cvs/general/imagemagick.html
export VERSION_IMAGICK=3.4.3        # https://github.com/mkoppanen/imagick/releases
export VERSION_JPGTURBO=1.5.1       # https://github.com/libjpeg-turbo/libjpeg-turbo/releases
export VERSION_LCMS2=2.8            # https://github.com/mm2/Little-CMS/releases
export VERSION_MATIO=1.5.10         # https://github.com/tbeu/matio/releases
export VERSION_NASM=2.13.01         # http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
export VERSION_OPENJPEG=2.1.2       # https://github.com/uclouvain/openjpeg/releases
export VERSION_OPENSSL=1.0.2k       # http://www.linuxfromscratch.org/blfs/view/8.0/postlfs/openssl.html
export VERSION_ORC=0.4.26           # https://github.com/GStreamer/orc/releases
export VERSION_PANGO=1.40.6         # https://github.com/GNOME/pango/releases
export VERSION_PCRE=8.40            # http://www.linuxfromscratch.org/blfs/view/svn/general/pcre.html
export VERSION_PHPVIPS=1.0.7        # https://github.com/jcupitt/php-vips-ext/releases
export VERSION_PIXMAN=0.34.0        # https://www.cairographics.org/releases/
export VERSION_PNG16=1.6.36         # https://libpng.sourceforge.io/
export VERSION_POPPLER=0.56.0       # https://poppler.freedesktop.org/
export VERSION_SVG=2.40.17          # https://github.com/GNOME/librsvg/releases
export VERSION_SWIG=3.0.12          # http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
export VERSION_TIFF=4.0.8           # https://github.com/vadz/libtiff/releases
export VERSION_EXT_VIPS_PHP=1.0.7   # https://github.com/jcupitt/php-vips-ext
export VERSION_WEBP=0.6.0           # https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html
export VERSION_XLST=1.1.33          # https://github.com/GNOME/libxslt/releases
export VERSION_XML2=2.9.4           # https://github.com/GNOME/libxml2/releases
export VERSION_ZLIB=1.2.11          # https://github.com/madler/zlib/releases

# Least out-of-sync Sourceforge mirror
export SOURCEFORGE_MIRROR=netix