#!/usr/bin/env bash

URL=${URL-https://the-live-url.de}

source <(curl ${URL}/common.sh)
DEPENDENCIES=("base-devel" "libcap")
DOCKER_DEPENDENCIES=("docker")

function getPackageSearchCommand() {
    printf "pacman -Qi %s > /dev/null 2>&1 &" "${1}"
}

function getPackageInstallCommand() {
    printf "sudo pacman -S --noconfirm %s" "${1}"
}

run
