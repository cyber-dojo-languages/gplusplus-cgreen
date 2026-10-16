#!/bin/bash -Eeu

# Appends one test framework to the test_frameworks list the base image
# wrote in /versions.json, keeping any entry an earlier image added. Stops
# the build if the list is not found, rather than record nothing.
add_test_framework()
{
  local -r name="${1}"
  local -r version="${2}"
  local -r entry="{\"name\": \"${name}\", \"version\": \"${version}\"}"
  if grep --quiet '"test_frameworks": \[\]' /versions.json; then
    sed -i "s|\"test_frameworks\": \[\]|\"test_frameworks\": [${entry}]|" /versions.json
  else
    sed -i "/\"test_frameworks\": \[/s|}\]|}, ${entry}]|" /versions.json
  fi
  if ! grep --quiet --fixed-strings "${entry}" /versions.json; then
    echo "Could not add ${name} to /versions.json" >&2
    cat /versions.json >&2
    exit 1
  fi
}

# Install the newest cgreen release. GitHub redirects releases/latest to the
# newest release's tag, which is resolved here at build time so a rebuild
# picks up the next release by itself.
readonly CGREEN_LATEST_URL=$(curl --silent --fail --output /dev/null --write-out '%{redirect_url}' \
  https://github.com/cgreen-devs/cgreen/releases/latest)
readonly CGREEN_TAG="${CGREEN_LATEST_URL##*/}"

# An empty tag means the redirect could not be read or has changed shape,
# not that cgreen stopped releasing, so stop rather than install nothing.
if [ -z "${CGREEN_TAG}" ]; then
  echo 'Found no cgreen release tag at github.com/cgreen-devs/cgreen' >&2
  exit 1
fi

apt-get update
apt-get install --yes cmake git
git clone --branch "${CGREEN_TAG}" https://github.com/cgreen-devs/cgreen.git
cd cgreen
cmake .
make
make install
cd ..
rm -rf cgreen
apt-get remove --yes cmake git

add_test_framework Cgreen "${CGREEN_TAG#v}"
cat /versions.json
