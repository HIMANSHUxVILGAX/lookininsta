#!/bin/bash
trap 'echo -e "\e[1;91mExiting cleanly...\e[0m"; exit 1;' SIGINT SIGTSTP

checkroot() {
    if [[ "$(id -u)" -ne 0 ]]; then
        printf "\e[1;77mPlease, run this program as root!\n\e[0m"
        exit 1
    fi
}

checkroot

printf "\e[1;92m[*] Checking and installing required packages...\e[0m\n"

(trap '' SIGINT SIGTSTP && command -v tor > /dev/null 2>&1 || { printf >&2 "\e[1;92mInstalling TOR, please wait...\n\e[0m"; apt-get update > /dev/null && apt-get -y install tor > /dev/null || printf "\e[1;91mTor Not installed.\n\e[0m"; }) & wait $!

(trap '' SIGINT SIGTSTP && command -v openssl > /dev/null 2>&1 || { printf >&2 "\e[1;92mInstalling OpenSSL, please wait...\n\e[0m"; apt-get update > /dev/null && apt-get -y install openssl > /dev/null || printf "\e[1;91mOpenSSL Not installed.\n\e[0m"; }) & wait $!

(trap '' SIGINT SIGTSTP && command -v curl > /dev/null 2>&1 || { printf >&2 "\e[1;92mInstalling cURL, please wait...\n\e[0m"; apt-get update > /dev/null && apt-get -y install curl > /dev/null || printf "\e[1;91mCurl Not installed.\n\e[0m"; }) & wait $!

printf "\e[1;92m[*] All required packages are installed successfully!\n\e[0m"

