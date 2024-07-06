#!/bin/zsh
set -eufo pipefail

# NOTE:
#   This script should only be used to install packages not available via Homebrew as a last resort.

download_dir=${HOME}/init/packages
package_urls=(
    # dockutil is required by 03_install_native_packages.sh
    https://github.com/kcrawford/dockutil/releases/download/3.0.2/dockutil-3.0.2.pkg
)

[ ! -d ${download_dir} ] && mkdir -p ${download_dir}
for url in ${package_urls[@]}; do
    package=${download_dir}/$(basename ${url})
    
    curl -Ls ${url} -o ${package}
    sudo installer -pkg ${package} -target /

    rm -f ${package} 
done
rmdir ${download_dir}