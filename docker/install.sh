#!/bin/bash -Eeu

apt-get update
apt-get install --yes cmake git
git clone https://github.com/cgreen-devs/cgreen.git
cd cgreen
cmake .
make
make install
cd ..
rm -rf cgreen
apt-get remove --yes cmake git
