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

# main {{{1
echo "Kernel Config check"

# Powertop {{{1
echo "Check Powertop needs"
sed -i 's/.*CONFIG_X86_MSR.*/CONFIG_X86_MSR=m/' .config

# Docker {{{1
echo "Check Docker needs"
sed -i 's/.*CONFIG_VETH.*/CONFIG_VETH=m/' .config
