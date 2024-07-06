#!/bin/zsh

# error exit enabled later as pkgutil receipt check will return non-zero exit code if package not installed.
set -ufo pipefail 

pkgutil --pkg-info com.apple.pkg.RosettaUpdateAuto &> /dev/null
set -e

if [ $? -ne 0 ]; then
    echo "Rosetta2 not installed."
    sudo softwareupdate --install-rosetta
else
    echo "Rosetta2 already installed."
fi