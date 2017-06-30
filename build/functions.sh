#!/bin/sh

# Standardize how we download and extract
fetchSource () {
    export DEP_NAME=$1
    url=$2
    build_dir=${DEPS}/${DEP_NAME}

    if [ ! -f ${build_dir}/downloaded.sts ]; then
        printf "\tDownloading to ${build_dir}\n"
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


        curl -Ls ${url} | tar ${tar_args} ${build_dir} --strip-components=1
        touch ${build_dir}/downloaded.sts
    else
        printf "\tAlready Downloaded\n"
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
    echo "{ ${JSON_VERSIONS} }" | jq --sort-keys '.' > ${TARGET}/lib/versions.json
}

packageVips () {
    echo "-------------------------------------------------------------------------------------------------"
    echo "|   Generating Package"
    echo "| "

    mkdir -p /packaging/dist
    cd ${TARGET}
    PACKAGE=/packaging/dist/libvips-${VERSION_VIPS}-lambda.tar.gz

    if [[ "${BUILD_PHP}" == "YES" ]]; then
        PACKAGE=/packaging/dist/vips-${VERSION_VIPS}_php-${VERSION_PHP}_ext-php-${VERSION_PHPVIPS}-lambda.tar.gz
    fi

    echo "|   ${PACKAGE} "
    echo "-------------------------------------------------------------------------------------------------"
    [[ -f "${PACKAGE}" ]] && rm "${PACKAGE}"
    tar czf ${PACKAGE} include lib bin modules etc
    advdef --recompress --shrink-insane ${PACKAGE}
}

pushd `dirname $0` > /dev/null
export BUILDPATH=`pwd`
popd > /dev/null

export -f fetchSource
export -f build
export -f start
export -f packageVips
export -f toJson