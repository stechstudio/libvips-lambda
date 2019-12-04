#!/bin/sh

fetchSource lcms2 http://${SOURCEFORGE_MIRROR}.dl.sourceforge.net/project/lcms/lcms/${VERSION_LCMS2}/lcms2-${VERSION_LCMS2}.tar.gz
export JSON_VERSIONS="${JSON_VERSIONS}, \"${DEP_NAME}\": \"${VERSION_LCMS2}\""

if [ ! -f "patched.sts" ]; then
    printf "\tPatching\n"
    # Apply patches for lcms2 vulnerabilities reported since v2.8
    VERSION_LCMS2_GIT_MASTER_SHA=$(curl -Ls https://api.github.com/repos/mm2/Little-CMS/git/refs/heads/master | jq -r '.object.sha' | head -c7)
    curl -Ls https://github.com/mm2/Little-CMS/compare/lcms2.8...master.patch | patch -p1 -t  >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1 || true
    touch patched.sts
else
    printf "\tAlready Patched\n"
fi

if [ ! -f "configured.sts" ]; then
    printf "\tConfiguring\n"
    ./configure  \
        --prefix=${TARGET} \
        --enable-shared \
        --disable-static \
        --disable-dependency-tracking >> ${BUILD_LOGS}/${DEP_NAME}.config.log 2>&1
    touch configured.sts
else
    printf "\tAlready Configured\n"
fi
if [ ! -f "made.sts" ]; then
    printf "\tBuilding\n"
    {
        make
        make install-strip
    } >> ${BUILD_LOGS}/${DEP_NAME}.make.log 2>&1
    touch made.sts
else
	printf "\tAlready Built\n"
fi
