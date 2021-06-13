#!/bin/bash
set -x

# Ensure all OS updates and basic packages are installed
command -v dnf >/dev/null \
    && dnf --assumeyes update \
    && dnf --assumeyes install bind-utils git jq nmap vim-enhanced wget
