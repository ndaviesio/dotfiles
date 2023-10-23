#!/bin/zsh

set -eufo pipefail

code_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

if [[ -f $code_bin ]]; then
    extensions=(
        bierner.markdown-preview-github-styles
        hashicorp.terraform
        me-dutour-mathieu.vscode-github-actions
        ms-python.python
    )
    for e ("$extensions[@]") $code_bin --install-extension $e --force
else 
    echo "Visual Studio Code not installed. Skipping extensions install"
fi