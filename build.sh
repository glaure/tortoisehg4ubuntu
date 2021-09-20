#!/bin/bash
#
# Copyright (c) 2021 Gunther Laure

set -e

# HG TAG
HG_TAG=5.9.1

# Clone tortoisehg repository.
if [ ! -e thg ]; then
    hg clone https://foss.heptapod.net/mercurial/tortoisehg/thg
else
    pushd thg
    hg pull
    hg update
    popd
fi

# Enter thg clone
pushd thg

# cleanup
hg update --clean 

# update to TAG
hg revert -r $HG_TAG --all

# build
make local

# done
echo ---------------
echo build completed
echo ---------------