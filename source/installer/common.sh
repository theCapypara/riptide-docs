#!/usr/bin/env bash

WHITE='\033[1;37m'
LIGHTGRAY='\033[0;37m'
GRAY='\033[1;30m'
BLACK='\033[0;30m'
RED='\033[0;31m'
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
BROWN='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
PURPLE='\033[0;35m'
PINK='\033[1;35m'
CYAN='\033[0;36m'
LIGHTCYAN='\033[1;36m'
NC='\033[0m'
BOLD='\033[1m'

HAS_PYTHON=$(command -v python3)
HAS_DOCKER=$(command -v docker)
HAS_SYSTEMD=$(command -v systemctl)
INSTALLED_PYTHON=$(python3 --version | awk '{ split($2, arr, "."); print arr[1]"."arr[2]; }')
SUPPORTED_PYTHON=("3.9" "3.10" "3.11" "3.12")
BIN_DIR=$HOME/.local/bin
declare -a MISSING_DEPENDENCIES
declare VIRTUALENV_NAME=riptide
declare VIRTUALENV_PATH
ADD_DOCKER=false
OUTPUT_WIDTH=70

read -r -d '' SYSTEMD_UNIT <<-'EOF'
[Unit]
Description=Riptide

[Service]
ExecStart=%s --user=%s
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF

UNIT_FILE='riptide_proxy.service'
UNIT_PATH='/etc/systemd/system'

##
# show activity
##
function printWait() {
    spin='⣷⣯⣟⡿⢿⣻⣽⣾'
    i=0
    tput civis
    while kill -0 ${1} 2>/dev/null; do
        i=$(( (i+1) %8 ))
        printf "\r${spin:$i:1} %-$((${OUTPUT_WIDTH}-1))s" "${2}"
        sleep .1
    done
    tput cnorm
    wait ${1}
    return $?
}

function printOK() {
    printf "%-${OUTPUT_WIDTH}s [${GREEN}%s${NC}]\n" "${1}" "OK"
}

function printFail() {
    printf "%-${OUTPUT_WIDTH}s [${RED}%s${NC}]\n" "${1}" "FAIL"
}

function printDivider() {
    printf "\n${LIGHTBLUE}=======================${NC}\n"
}

function printDone() {
    printf "\n...done."
    printf "\nWe strongly recommend to reboot your machine for all changes to take effect."
    printf "\nTo begin using riptide without reboot invoke '%s' and '%s'\n" "newgrp docker" "source ~/.(ba|z)shrc"
}

##
# check systemd
##
function checkSystemd() {
    MSG="Checking for systemd"
    if [[ ${HAS_SYSTEMD} ]]; then
        printOK "${MSG}"
    else
        printFail "${MSG}"
    fi
}

##
# check if given version number is compatible with riptide
##
function checkPythonVersion() {
    if [[ ${HAS_PYTHON} ]] && [[ ${SUPPORTED_PYTHON[@]} =~ ${INSTALLED_PYTHON} ]]; then
        printOK "Python ${INSTALLED_PYTHON} installed..."
        return 0
    else
        printFail "No compatible Python version found..."
    fi
    return 1
}

##
# check docker
##
function checkDocker() {
    MSG="Checking for docker/podman"
    if [[ ${HAS_DOCKER} ]]; then
        printOK "${MSG}"
        return 0
    else
        printFail "${MSG}"
        printf "\nDocker must be installed for riptide to work.\n"
        printf "${LIGHTGREEN}I${NC}nstall/${LIGHTGREEN}M${NC}anual installation/${LIGHTGREEN}C${NC}ancel? (I/m/c) "
        read -n1 < /dev/tty
        if [[ ${REPLY} == "" ]] || [[ ${REPLY} == [Ii] ]]; then
            DEPENDENCIES+=("${DOCKER_DEPENDENCIES[@]}")
            HAS_DOCKER=true
            return 0
        fi
        if [[ ${REPLY} == [Mm] ]]; then
            printf "\nPlease install docker and docker-rootless-extras via your distros package manager or refer to the official docker manuals https://docs.docker.com/manuals/\n"
            printf "\nAdd your user to the docker group afterwards.\n"
            return 0
        fi
    fi
    return 1
}

##
# check single dependency
##
function checkDependency() {
    eval $(getPackageSearchCommand ${1})
    if printWait $! "Checking for ${1}"; then
        echo -e [${GREEN}OK${NC}];
    else
        MISSING_DEPENDENCIES+=( ${1} );
        echo -e [${RED}FAIL${NC}];
    fi
}

##
# check dependencies. add to dependencies array if missing
##
function checkDependencies() {
    OLDIFS=${IFS}
    IFS=$'\n'
    for i in ${DEPENDENCIES[@]}; do
        checkDependency "$i"
    done
    IFS=${OLDIFS}
}

##
# install missing dependencies
##
function installDependencies() {
    printf "We are going to install the "

    if [[ ${MISSING_DEPENDENCIES[@]} != "" ]]; then
        printf "package(s) ${YELLOW}%s${NC}" "${MISSING_DEPENDENCIES[*]}. "
    fi

    read -n1 -p 'Proceed? (Y/n): ' < /dev/tty
    if [[ ${REPLY} == "" ]] || [[ ${REPLY} == [Yy] ]]; then
        printf "\nInstalling...\n"
        if [[ ${MISSING_DEPENDENCIES[@]} != "" ]]; then
            OLDIFS=${IFS}
            IFS=$'\n'
            for i in ${MISSING_DEPENDENCIES[@]}; do
                eval $(getPackageInstallCommand ${i})
            done
            IFS=${OLDIFS}
            if [[ ${MISSING_DEPENDENCIES[@]} =~ "docker" ]]; then
                sudo systemctl enable --now docker.service
            fi
        fi
    else
        exit 1
    fi
}

##
# determine virtualenv installation path
##
function determineEnvPath() {

    printf "We are going to create a directory for the virtualenv. Please give it a name.\n"
    read -p "Name (${VIRTUALENV_NAME}): " < /dev/tty
    [[ ${REPLY} == "" ]] || VIRTUALENV_NAME=${REPLY}

    printf "\nEnter the path where you want the directory for riptide to be installed.\n"
    read -e -p "Path: (${HOME}): " < /dev/tty
    [[ ${REPLY} == "" ]] && BASEPATH=${HOME} || BASEPATH=${REPLY}

    REALBASEPATH=$(realpath ${BASEPATH/#\~/$HOME} 2> /dev/null)
    if [[ ! -e ${REALBASEPATH} ]]; then
        printf "Path ${RED}%s${NC} does not exist. Create it? (Y/n): " "${REALBASEPATH}"
        read -n1 < /dev/tty
        if [[ ${REPLY} == "" ]] || [[ ${REPLY} == [Yy] ]]; then
            mkdir -p ${BASEPATH/#\~/$HOME}
        fi
        echo
    fi

    REALPATH=$(realpath ${BASEPATH/#\~/$HOME}/${VIRTUALENV_NAME} 2> /dev/null)

    if [[ -e ${REALPATH} ]]; then
        printf "${RED}Path %s already exists.${NC} Please choose another one.\n" "${REALPATH}"
    elif [[ ${REALPATH} == "" ]]; then
        printf "${RED}%s/%s is not a real path.${NC} Please choose an existing path.\n" "${BASEPATH/#\~/$HOME}" "${VIRTUALENV_NAME}"
    else
        printf "Virtualenv will be installed to %s\n" "${REALPATH}"
        VIRTUALENV_PATH=${REALPATH}
        return 0
    fi
    printDivider
    return 1
}

##
# create virtualenv
##
function createEnv() {
    printf "\nCreating virtualenv %s\n" ${VIRTUALENV_PATH}
    local PYTHON=python${INSTALLED_PYTHON}
    ${PYTHON} -m venv ${VIRTUALENV_PATH} &
    if printWait $! "Creating virtualenv..."; then
        echo -e [${GREEN}OK${NC}];
        return 0
    else
        echo -e [${RED}FAIL${NC}];
    fi
    return 1
}

##
# install riptide
##
function installRiptide() {
    cd ${VIRTUALENV_PATH}
    source bin/activate
    pip3 install riptide-all
}

##
# initialize environment
##
function initEnvironment() {
    printf "\n"
    BASHRC=${HOME}/.bashrc
    ZSHRC=${HOME}/.zshrc
    [[ $(tail -n1 "${BASHRC}" | wc -w) -gt 0 ]] && printf "\n" >> ${BASHRC}

    [[ -e ${BIN_DIR} ]] || mkdir -p ${BIN_DIR}

    if [[ ":$PATH:" != *":${BIN_DIR}:"* ]]; then
        printf "PATH is missing %s. Adding it to %s\n" "${BIN_DIR}" "${BASHRC}"
        printf 'PATH=$PATH:%s\n' ${BIN_DIR}  >> ${BASHRC}
        [[ -e ${ZSHRC} ]] && printf 'PATH=$PATH:%s\n' ${BIN_DIR}  >> ${ZSHRC}
    fi
    if ! grep -q 'riptide.hook.bash' ${BASHRC}; then
        printf "Adding riptide hook to %s\n" "${BASHRC}"
        printf 'source %s/bin/riptide.hook.bash\n' ${VIRTUALENV_PATH} >> ${BASHRC}
    fi
    if ! grep -q '_RIPTIDE_COMPLETE' ${BASHRC}; then
        printf "Adding bash completion to %s\n" "${BASHRC}"
        printf 'eval "$(_RIPTIDE_COMPLETE=source_bash riptide)"\n' >> ${BASHRC}
    fi

    if [[ -e ${ZSHRC} ]]; then
        [[ $(tail -n1 "${ZSHRC}" | wc -w) -gt 0 ]] && printf "\n" >> ${ZSHRC}
        if [[ ":$PATH:" != *":${BIN_DIR}:"* ]]; then
            printf "PATH is missing %s. Adding it to %s\n" "${BIN_DIR}" "${ZSHRC}"
            printf 'PATH=$PATH:%s\n' ${BIN_DIR}  >> ${ZSHRC}
        fi
        if ! grep -q 'riptide.hook.bash' ${ZSHRC}; then
            printf "Adding riptide hook to %s\n" "${ZSHRC}"
            printf 'source %s/bin/riptide.hook.zsh\n' ${VIRTUALENV_PATH} >> ${ZSHRC}
        fi
        if ! grep -q '_RIPTIDE_COMPLETE' ${ZSHRC}; then
            printf "Adding bash completion to %s\n" "${ZSHRC}"
            printf 'eval "$(_RIPTIDE_COMPLETE=source_zsh riptide)"\n' >> ${ZSHRC}
        fi
    fi

    printf "Linking executables to %s\n" "${BIN_DIR}"
    ln -s ${VIRTUALENV_PATH}/bin/riptide ${BIN_DIR}
    ln -s ${VIRTUALENV_PATH}/bin/riptide_upgrade ${BIN_DIR}
    ln -s ${VIRTUALENV_PATH}/bin/riptide_proxy ${BIN_DIR}

    printf "Creating default config %s\n" "${HOME}/.config/riptide/config.yml"
    RIPTIDE_FACTORY_CONFIG=$(EDITOR=$(which cat) riptide config-edit-user --factoryreset)
    echo "${RIPTIDE_FACTORY_CONFIG}" > ${HOME}/.config/riptide/config.yml
    sed -i '1,/^#/d' ${HOME}/.config/riptide/config.yml

    printf "Setting hosts file acl\n"
    sudo setfacl -m u:${USER}:rw /etc/hosts

    if [[ ${HAS_DOCKER} ]]; then
        printf "Adding user '%s' to docker group\n" ${USER}
        sudo usermod -aG docker ${USER}
    fi
}

##
# install proxy unit
##
function installProxyUnit() {
    printf "\n"
    MSG='Install systemd unit'
    if [[ ! -e ${UNIT_PATH}/${UNIT_FILE} ]]; then
        printf "${SYSTEMD_UNIT}" "${HOME}/.local/bin/riptide_proxy"  "${USER}" | sudo tee ${UNIT_PATH}/${UNIT_FILE} > /dev/null
        sudo systemctl daemon-reload
        sudo systemctl enable --now ${UNIT_FILE}
        printOK "${MSG}"
    else
        printFail "${MSG}"
        printf "\nA systemd unit file ${RED}%s${NC} seems to be installed already.\nPlease check manually.\n" "${UNIT_PATH}/${UNIT_FILE}"
    fi
}

function run() {
    printf "\nRiptide Installer 1.0.0"
    printDivider

    printf "\nCheck Environment\n"
    checkSystemd
    checkDocker || exit 1
    printDivider

    printf "\nChecking Python and dependencies\n"
    checkPythonVersion || exit 1
    checkDependencies
    printDivider

    printf "\nDetermine directory for virtualenv\n"
    while [[ ${VIRTUALENV_PATH} == "" ]]; do determineEnvPath; done
    printDivider

    if [[ ${MISSING_DEPENDENCIES[@]} != "" ]]; then
        printf "\nInstall missing dependencies\n"
        installDependencies
        printDivider
    fi

    createEnv && installRiptide
    printDivider

    initEnvironment
    [[ ${HAS_SYSTEMD} ]] && printDivider && installProxyUnit

    printDivider
    printDone
}