#!/usr/bin/env bash

# Run perltidy on perl scripts. Scripts are modified in place. A copy will be
# saved with .bak extension.
# By default, perltidy will look for .perltidyrc current directory (repository
# root) and in the home directory. If no config file is found then perltidy will
# run with --perl-best-practices.

set -eu

cmd=perltidy
if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "This check needs ${cmd} from http://perltidy.sourceforge.net/."
    exit 1
fi

cfg=.perltidyrc
opts=(--nostandard-output --warning-output --backup-and-modify-in-place)
if [[ ! -r "${cfg}" ]] && [[ ! -r "$HOME/${cfg}" ]]; then
    opts=("--noprofile" "--perl-best-practices" "${opts[@]}")
fi

if ! output=$("${cmd}" "${opts[@]}" "$@" 2>&1); then
    echo "${output}"
    exit 1
fi
