#!/bin/zsh

set -eufo pipefail
autoload colors; colors

# Script Parameters
brew_bin=/opt/homebrew/bin/brew
work_device=false

echo "👋 This script will bootstrap and setup the device."
read -s -k $'?    Press any key to continue or Ctrl+C to abort...\n\n'

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
[ -f ${brew_bin} ] && \
     echo $fg[green]"🍺 Homebrew already present"$reset_color || \
    (echo "==> Homebrew not installed, installing..." && /bin/bash -c "$(sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && echo $fg[green]"🍺 Homebrew installed"$reset_color)

# Presuming the shell is not yet configured, ensure current session is configured for brew
eval "$(${brew_bin} shellenv)"

# Install Chezmoi
command -v chezmoi >/dev/null 2>&1 && \
     echo $fg[green]"🔧 Chezmoi already present"$reset_color || \
    (echo "==> Chezmoi not installed, installing..." && brew install --quiet chezmoi && echo $fg[green]"🔧 Chezmoi installed"$reset_color)

# Chezmoi Initialisation
echo "🔧 Chezmoi First-time Initilisation"

# Interactively confirm preset initialistion parameters
echo $fg[yellow]"   Confirm initialisation settings:"$reset_color

read -r res$'?       Repository ('$repo'): '
[[ ! -z $res ]] && repo=$res # Only overwrite default if non-empty response given

$work_device && default='Y' || default='N'
read -r -k res$'?       Setup device for work? (default is "'$default'"): [Y/n] '
case $res in
    [Yy]* ) work_device=true; echo "";;
    [Nn]* ) work_device=false; echo "";;
    *) echo -e "\n$fg[yellow]         Invalid response provided. Reverting to default: $default$reset_color"; work_device=$work_device;;
esac

echo "   Starting Setup"
chezmoi init --promptBool work=$work_device --apply https://github.com/${repo}
echo $fg[green]"✅ Initial Setup Complete$reset_color"
