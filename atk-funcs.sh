#!/usr/bin/env bash
#INFO: Useful to source in all our programs. Has common utility functions.
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

verbose=0

e_header() { 
    echo; echo -n "${bold}${purple}==========" ; echo -n $@; echo "==========${reset}" 
}
e_arrow() { echo "➜ $@" 
}
e_success() { echo -n "${green}✔ "; echo -n "$@" ; echo "${reset}" 
}
e_error() { echo -n "${red}✖ "; echo -n "$@"; echo "${reset}" 
}
e_warning() { echo -n "${tan}➜ "; echo -n "$@"; echo "${reset}"
}
e_underline() { echo "${underline}${bold} $@ ${reset}" 
}
e_bold() { echo "${bold} $@ ${reset}"  
}
e_note() { echo -n "${underline}${bold}${blue}Note:${reset}  ${blue}"
    echo -n $@
    echo "${reset}" 
}

# Test which OS the user runs
# $1 = OS to test
# Usage: if is_os 'darwin'; then
#

is_os() {
    if [[ "${OSTYPE}" == $1* ]]; then
        return 0
    fi
    return 1
}

is_mac() {
    return is_os "darwin"
}

is_linux() {
    return is_os "linux-gnu"
}

running_as_root() {
    if [[ ${EUID} -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

command_exists() {
    command -v ${1} >/dev/null 2>&1 || return 1
    return 0    
}

