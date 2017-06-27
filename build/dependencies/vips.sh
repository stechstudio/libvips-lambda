#!/bin/sh
set -e

fetchSource vips https://github.com/jcupitt/libvips/releases/download/v${VERSION_VIPS}/vips-${VERSION_VIPS}.tar.gz

./configure  --prefix=${TARGET} --enable-shared --disable-static --disable-dependency-tracking \
  --disable-debug --disable-introspection --without-python --without-fftw \
  --without-magick --without-pangoft2 --without-ppm --without-analyze --without-radiance \
  --with-zlib-includes=${TARGET}/include --with-zlib-libraries=${TARGET}/lib \
  --with-jpeg-includes=${TARGET}/include --with-jpeg-libraries=${TARGET}/lib \
  --with-png-includes=${TARGET}/include --with-png-libraries=${TARGET}/lib \
  --with-giflib-includes=${TARGET}/include --with-giflib-libraries=${TARGET}/lib \
  --with-tiff-includes=${TARGET}/include --with-tiff-libraries=${TARGET}/lib \
  --with-libwebp-includes=${TARGET}/include --with-libwebp-libraries=${TARGET}/lib \

make install-strip