#!/usr/bin/env bash

# Run perlimports on perl scripts.

set -eu

cmd=perlimports
if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "This check needs ${cmd} from https://github.com/oalders/App-perlimports."
    exit 1
fi

if ! output=$("${cmd}" "$@" 2>&1); then
    echo "${output}"
    exit 1
fi
