#!/bin/bash
set -e

apt-get update
apt-get install --yes wget cmake unzip

wget https://github.com/cgreen-devs/cgreen/archive/master.zip
unzip master.zip
rm master.zip
cd cgreen-master
mkdir build
cd build
cmake -DCGREEN_WITH_CXX:bool=ON ..
make
make install

apt-get remove --yes wget cmake unzip
