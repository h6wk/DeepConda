#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

#Exit immediately if a command exits with a non-zero status.
set -e

INSTALL_ZSH=${1:-"true"}
USERNAME=${2:-"automatic"}
USER_UID=${3:-"automatic"}
USER_GID=${4:-"automatic"}
UPGRADE_PACKAGES=${5:-"true"}
INSTALL_OH_MYS=${6:-"true"}
ADD_NON_FREE_PACKAGES=${7:-"false"}
SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

echo $SCRIPT_DIR

# interrupt if caller is not the root
if [ "$(id -u)" -ne 0 ]; then
  exit 1
fi

if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in ${POSSIBLE_USERS[@]}; do
        if id -u ${CURRENT_USER} > /dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=vscode
    fi
elif [ "${USERNAME}" = "none" ]; then
    USERNAME=root
    USER_UID=0
    USER_GID=0
fi
echo "User to create: " $USERNAME

# Function to call apt-get if needed
apt_get_update_if_needed()
{
  if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
    echo "Running apt-get update..."
    apt-get update
  else
    echo "Skipping apt-get update."
  fi
}

apt_get_update_if_needed

# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Run install apt-utils to avoid debconf warning then verify presence of other common developer tools and dependencies
if [ "${PACKAGES_ALREADY_INSTALLED}" != "true" ]; then

    package_list="apt-utils \
        wget \
        sudo"
        
    # Needed for adding manpages-posix and manpages-posix-dev which are non-free packages in Debian
    if [ "${ADD_NON_FREE_PACKAGES}" = "true" ]; then
        # Bring in variables from /etc/os-release like VERSION_CODENAME
        . /etc/os-release
        sed -i -E "s/deb http:\/\/(deb|httpredir)\.debian\.org\/debian ${VERSION_CODENAME} main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME} main contrib non-free/" /etc/apt/sources.list
        sed -i -E "s/deb-src http:\/\/(deb|httredir)\.debian\.org\/debian ${VERSION_CODENAME} main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME} main contrib non-free/" /etc/apt/sources.list
        sed -i -E "s/deb http:\/\/(deb|httpredir)\.debian\.org\/debian ${VERSION_CODENAME}-updates main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME}-updates main contrib non-free/" /etc/apt/sources.list
        sed -i -E "s/deb-src http:\/\/(deb|httpredir)\.debian\.org\/debian ${VERSION_CODENAME}-updates main/deb http:\/\/\1\.debian\.org\/debian ${VERSION_CODENAME}-updates main contrib non-free/" /etc/apt/sources.list
        sed -i "s/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main contrib non-free/" /etc/apt/sources.list
        sed -i "s/deb-src http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}\/updates main contrib non-free/" /etc/apt/sources.list
        sed -i "s/deb http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main/deb http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main contrib non-free/" /etc/apt/sources.list 
        sed -i "s/deb-src http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main/deb http:\/\/deb\.debian\.org\/debian ${VERSION_CODENAME}-backports main contrib non-free/" /etc/apt/sources.list
        # Handle bullseye location for security https://www.debian.org/releases/bullseye/amd64/release-notes/ch-information.en.html
        sed -i "s/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main contrib non-free/" /etc/apt/sources.list
        sed -i "s/deb-src http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main/deb http:\/\/security\.debian\.org\/debian-security ${VERSION_CODENAME}-security main contrib non-free/" /etc/apt/sources.list
        echo "Running apt-get update..."
        apt-get update
        package_list="${package_list} manpages-posix manpages-posix-dev"
    else
        apt_get_update_if_needed
    fi

    echo "Packages to verify are installed: ${package_list}"
    apt-get -y install --no-install-recommends ${package_list} 2> >( grep -v 'debconf: delaying package configuration, since apt-utils is not installed' >&2 )
        
    # Install git if not already installed (may be more recent than distro version)
    if ! type git > /dev/null 2>&1; then
        apt-get -y install --no-install-recommends git
    fi

    PACKAGES_ALREADY_INSTALLED="true"
fi

# Get to latest versions of all packages
if [ "${UPGRADE_PACKAGES}" = "true" ]; then
    apt_get_update_if_needed
    apt-get -y upgrade --no-install-recommends
    apt-get autoremove -y
fi