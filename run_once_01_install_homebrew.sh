#!/bin/zsh
set -eufo pipefail

brew_bin=/opt/homebrew/bin/brew

# Install Homebrew
[ ! -f ${brew_bin} ] && \
    /bin/bash -c "$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || \
    echo "Homebrew already installed."