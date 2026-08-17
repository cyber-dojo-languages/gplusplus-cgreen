#!/bin/bash -Eeu

readonly CGREEN_VERSION=1.7.0

apt-get update
apt-get install --yes cmake git
git clone --branch "${CGREEN_VERSION}" https://github.com/cgreen-devs/cgreen.git
cd cgreen
cmake .
make
make install
cd ..
rm -rf cgreen
apt-get remove --yes cmake git
