#!/usr/bin/env bash

URL=${URL-https://the-live-url.de}
source <(curl ${URL}/common.sh)

DEPENDENCIES=("package libcap-devel" "pattern devel_basis")
INSTALLED_PYTHON_NO_DOTS=$(awk -v version="${INSTALLED_PYTHON}" 'BEGIN{ split(version, arr, "."); print arr[1]arr[2] }')
DEPENDENCIES+=("package python${INSTALLED_PYTHON_NO_DOTS}-devel")
DOCKER_DEPENDENCIES=("package docker" "package docker-rootless-extras")

function getPackageSearchCommand() {
    printf "zypper se --installed-only -t %s > /dev/null &" "${1}"
}

function getPackageInstallCommand() {
    printf "sudo zypper --non-interactive in -t %s" "${1}"
}

run