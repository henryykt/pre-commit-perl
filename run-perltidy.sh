#!/usr/bin/env bash

# Run perltidy on perl scripts.
# Scripts are modified in place. A copy will be saved with .bak extension.
# By default, pertidy runs with --perl-best-practices. This can be overruled
# using a .perltidyrc configuration file in the repository root.

set -eu

cmd=perltidy
if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Command ${cmd} not found"
    exit 1
fi

cfg=.perltidyrc
opts=""
if [[ -r "${cfg}" ]]; then
    opts=("-pro=${cfg}")
else
    # Default options
    opts=(-pbp)
fi

output=$("${cmd}" "${opts[@]}" -nst -w -b "$@" 2>&1)

if [[ -n "${output}" ]]; then
    echo "${output}"
    exit 1
fi
