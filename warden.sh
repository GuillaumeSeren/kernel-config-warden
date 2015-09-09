#!/bin/bash
# -*- coding: UTF8 -*-

# This script check to keep some options in the Kernel,
# even after a localmodconfig.

echo "Kernel Config check"
# Powertop {{{1
echo "Check Powertop needs"
sed -i 's/.*CONFIG_X86_MSR.*/CONFIG_X86_MSR=m/' .config

# Docker {{{1
echo "Check Docker needs"
sed -i 's/.*CONFIG_VETH.*/CONFIG_VETH=m/' .config
