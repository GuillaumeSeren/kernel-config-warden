#!/bin/bash
# -*- coding: UTF8 -*-
# ---------------------------------------------
# @author:  Guillaume Seren
# @since:   08/09/2015
# source:   https://github.com/GuillaumeSeren/kernel-config-warden
# file:     warden.sh
# Licence:  GPLv2+
#
# This script check to keep some options in the Kernel,
# even after a localmodconfig.
# ---------------------------------------------

# TaskList {{{1
# @TODO: Add param for the script call.
# @TODO: Add usage function to provide help.
# @TODO: Add main function to centralize the process.
# @TODO: Add a param to select the option in list: docker,powertop .
# @TODO: Add a function to test need external programs (sed).

# Error Codes {{{1
# 0 - Ok
# 1 - Error in cmd / options
# 2 - Given config file don't exist or not readable.

# usage() {{{1
# Return the helping message for the use.
function usage()
{
cat << DOC

usage: "$0" options

This script check needed param in the kernel config.


OPTIONS:
    -h  Show this message.
    -f  File (full-path) of the .config to check.

Sample:
    # Simple default patching of the config
    "$0" -f /tmp/linux/.config

DOC
}

# getValidateFile() {{{1
function getValidateFile() {
    local file=""
    # Did the file exist ?
    if [ -w "$1" ]; then
        file="$1"
    fi
    echo "$file"
}

# GETOPTS {{{1
# Get the param of the script.
while getopts "f:h" OPTION
do
    flagGetOpts=1
    case $OPTION in
    h)
        usage
        exit 1
        ;;
    f)
        # check the file
        cmdFile="$(getValidateFile "$OPTARG")"
        if [[ "$cmdFile" == "" ]]; then
            echo "The give config file is invalid: $OPTARG"
            echo "Please check path and permissions of this file."
            exit 2
        fi
        ;;
    ?)
        echo "commande $1 inconnue"
        usage
        exit
        ;;
    esac
done
# We check if getopts did not find no any param
if [ "$flagGetOpts" == 0 ]; then
    echo 'This script cannot be launched without options.'
    usage
    exit 1
fi

# main {{{1
function main() {
    echo "Kernel Config check"
    # Powertop
    echo "Check Powertop needs"
    sed -i 's/.*CONFIG_X86_MSR.*/CONFIG_X86_MSR=m/' "$cmdFile"
    # Docker
    echo "Check Docker needs"
    sed -i 's/.*CONFIG_VETH.*/CONFIG_VETH=m/' "$cmdFile"
}
main
