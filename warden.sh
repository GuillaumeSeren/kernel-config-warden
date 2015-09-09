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

# FUNCTION usage() {{{1
# Return the helping message for the use.
function usage()
{
cat << DOC

usage: "$0" options

This script check needed param in the kernel config.


OPTIONS:
    -h  Show this message.

Sample:

DOC
}

# GETOPTS {{{1
# Get the param of the script.
while getopts ":h" OPTION
do
    flagGetOpts=1
    case $OPTION in
    h)
        usage
        exit 1
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
    # Powertop {{{1
    echo "Check Powertop needs"
    sed -i 's/.*CONFIG_X86_MSR.*/CONFIG_X86_MSR=m/' .config
    # Docker {{{1
    echo "Check Docker needs"
    sed -i 's/.*CONFIG_VETH.*/CONFIG_VETH=m/' .config
}
main
