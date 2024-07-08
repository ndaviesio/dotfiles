#!/bin/zsh
set -ufo pipefail

brew_bin=/opt/homebrew/bin/brew
FORMULAE=(
    # Utilities
    stats

    # Dev Tools
    spaceship
    git
    gh #github-cli
    awscli
    tfenv
    pyenv
    nvm
)

CASKS=(
    # Core Applications
    proton-mail
    proton-drive
    proton-pass
    tailscale
    nextcloud
    spotify
    discord
    microsoft-office
    microsoft-teams
    microsoft-edge
    logitech-options

    # Utilities
    alfred

    # Dev Tools
    visual-studio-code
    warp
    docker
)

CASKS_BYPASS_GATEKEEPER=(
    ## No Quarantine Installs
    ##  Place last to avoid --no-quarantine being applied to other installs.
    ##  https://github.com/orgs/Homebrew/discussions/3348
    librewolf
)

UNINSTALLS=(
)

${brew_bin} update
[ ${#UNINSTALLS[@]} -gt 0 ] && \
    ${brew_bin} uninstall ${UNINSTALLS[@]}
${brew_bin} install ${FORMULAE[@]}
${brew_bin} install --cask ${CASKS[@]}
${brew_bin} install --no-quarantine --cask  ${CASKS_BYPASS_GATEKEEPER[@]}
${brew_bin} cleanup
