#!/usr/bin/env bash

URL=https://raw.githubusercontent.com/theCapypara/riptide-docs/master/source/installer
source <(curl ${URL}/common.sh)

DEPENDENCIES=("libcap-dev" "python3-dev" "python3-venv" "build-essential")
DOCKER_DEPENDENCIES=("docker.io")

function getPackageSearchCommand() {
    printf "dpkg-query -s %s > /dev/null 2>&1 &" "${1}"
}

function getPackageInstallCommand() {
    printf "sudo apt install -y %s" "${1}"
}

run
