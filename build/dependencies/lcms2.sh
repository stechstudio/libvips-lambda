#!/bin/sh \
set -e

rm -rf ${DEPS}/lcms2

fetchSource lcms2 http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/lcms/lcms/${VERSION_LCMS2}/lcms2-${VERSION_LCMS2}.tar.gz


# Apply patches for lcms2 vulnerabilities reported since v2.8
VERSION_LCMS2_GIT_MASTER_SHA=$(curl -Ls https://api.github.com/repos/mm2/Little-CMS/git/refs/heads/master | jq -r '.object.sha' | head -c7)
curl -Ls https://github.com/mm2/Little-CMS/compare/lcms2.8...master.patch | patch -p1 -t || true

./configure  \
    --prefix=${TARGET} \
    --enable-shared \
    --disable-static \
    --disable-dependency-tracking


make install-strip