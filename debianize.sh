#!/bin/bash
#
# Copyright (c) 2021 Gunther Laure

set -e
set -x


function message
{
    echo "$*" 1>&2
}

function warning
{
    message WARNING: $*
}

function die
{
    message "-----------------------------------------------------------------"
    message Error: $0: $*
    exit 1
}




if type lsb_release >/dev/null 2>&1; then
    LSB_RELEASE_BIN=$(which lsb_release)
fi


if [ -x "$LSB_RELEASE_BIN" ]; then
    distributor_id=$($LSB_RELEASE_BIN --id --short)
    release=$($LSB_RELEASE_BIN --release --short)

    if [[ $distributor_id == *Ubuntu* ]]; then
        if [[ $release == "20.04" ]]; then
            rm -rf thg/debian
            cp -r packaging/Ubuntu2004/debian thg
        else
            die "Unsupported LSB distribution $($LSB_RELEASE_BIN --id --short) $($LSB_RELEASE_BIN --release --short) $($LSB_RELEASE_BIN --codename --short)"
        fi
    else
        die "Unsupported LSB distribution $($LSB_RELEASE_BIN --id --short) $($LSB_RELEASE_BIN --release --short) $($LSB_RELEASE_BIN --codename --short)"
    fi
    
fi



pushd thg

# # add version to changelog
# if ! dch --newversion "${PKG_VERSION}${PKG_TAG}-${DIST}" --maintmaint "CI build"
# then
#     die "debchange failed"
# fi

# build package
if [ -x debian/rules ]
then
    if ! DEB_BUILD_OPTIONS="parallel=$NUM_CPU $DEB_BUILD_OPTIONS" fakeroot debian/rules binary
    then
        die "build: debian/rules binary failed"
    fi
else
    die "build: did not find a valid debian/rules file"
fi

popd
