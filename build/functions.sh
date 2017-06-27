#!/bin/sh
set -e

# Standardize how we download and extract
fetchSource () {

    url=$2
    build_dir=${DEPS}/$1
    if [ ! -f ${build_dir}/build_downloaded ]; then
        mkdir -p ${build_dir}

        case "$url" in
            *.tar.xz)
                tar_args=xJC
                ;;
            *.tar.gz)
                tar_args=xzC
                ;;
            *.tgz)
                tar_args=xzC
                ;;
            *.tar.bz2)
                tar_args=xjC
                ;;
            *)
                echo "I can only handle .xz, .bz2, or .gz"
                exit 1
        esac

        echo "curl -Ls ${url} | tar ${tar_args} ${build_dir} --strip-components=1"
        curl -Ls ${url} | tar ${tar_args} ${build_dir} --strip-components=1
        touch ${build_dir}/build_downloaded
    fi
    cd ${build_dir}
}

start () {
    echo "-------------------------------------------------------------------------------------------------"
    echo "|   Begin Building ${1}"
    echo "-------------------------------------------------------------------------------------------------"
}

build () {
    start $1
    source "${BUILDPATH}/dependencies/${1}.sh"
}

toJson () {
    echo "{\
        \"xml\": \"${VERSION_XML2}\",
        \"cairo\": \"${VERSION_CAIRO}\",
        \"croco\": \"${VERSION_CROCO}\",
        \"exif\": \"${VERSION_EXIF}\",
        \"expat\": \"${VERSION_EXPAT}\",
        \"ffi\": \"${VERSION_FFI}\",
        \"fontconfig\": \"${VERSION_FONTCONFIG}\",
        \"freetype\": \"${VERSION_FREETYPE}\",
        \"gdkpixbuf\": \"${VERSION_GDKPIXBUF}\",
        \"gif\": \"${VERSION_GIF}\",
        \"glib\": \"${VERSION_GLIB}\",
        \"gsf\": \"${VERSION_GSF}\",
        \"harfbuzz\": \"${VERSION_HARFBUZZ}\",
        \"jpeg\": \"${VERSION_JPEG}\",
        \"lcms\": \"${VERSION_LCMS2}-${VERSION_LCMS2_GIT_MASTER_SHA}\",
        \"orc\": \"${VERSION_ORC}\",
        \"pango\": \"${VERSION_PANGO}\",
        \"pixman\": \"${VERSION_PIXMAN}\",
        \"png\": \"${VERSION_PNG16}\",
        \"svg\": \"${VERSION_SVG}\",
        \"tiff\": \"${VERSION_TIFF}-${VERSION_TIFF_GIT_MASTER_SHA}\",
        \"vips\": \"${VERSION_VIPS}\",
        \"webp\": \"${VERSION_WEBP}\",
        \"zlib\": \"${VERSION_ZLIB}\",
        \"curl\": \"${VERSION_CURL}\",
        \"poppler\": \"${VERSION_POPPLER}\",
        \"openjpeg\": \"${VERSION_OPENJPEG}\",
        \"php\": \"${VERSION_PHP}\",
        \"php-vips-ext\": \"${VERSION_PHPVIPS}\",
}" | jq --sort-keys '.' > ${TARGET}/lib/versions.json
}

pushd `dirname $0` > /dev/null
export BUILDPATH=`pwd`
popd > /dev/null

export -f fetchSource
export -f start