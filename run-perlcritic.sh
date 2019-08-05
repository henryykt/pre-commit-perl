#!/usr/bin/env bash

# Run perlcritic on perl scripts.
# By default perlcritic looks for .perlcriticrc in the current directory
# (repository root) and in the home directory. If no configuration file is
# found then it uses --stern and --verbose 8.

set -eu

cmd=perlcritic
if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "This check needs ${cmd} from https://github.com/Perl-Critic/Perl-Critic."
    exit 1
fi

cfg=.perlcriticrc
opts=("--quiet")
if [[ ! -r "${cfg}" ]] && [[ ! -r "$HOME/${cfg}" ]]; then
    opts+=("--stern" "--verbose" "8")
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
