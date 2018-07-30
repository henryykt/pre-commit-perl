#!/usr/bin/env bash

# Run perlcritic on perl scripts.
# perlcritic uses .perlcriticrc if available, otherwise it uses --stern --verbose 8.

set -eu

cmd=perlcritic
if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Command ${cmd} not found"
    exit 1
fi

cfg=.perlcriticrc
opts=""
if [[ -r "${cfg}" ]]; then
    opts=()
else
    # Default options
    opts=(--stern --verbose 8)
fi

failed=false
for file in "$@"; do
    if ! output=$("${cmd}" "${opts[@]}" "${file}" 2>&1); then
        echo "${file}:"
        echo "${output}"
        failed=true
    fi
done

if [[ $failed == "true" ]]; then
    exit 1
fi
