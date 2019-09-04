#!/usr/bin/env bash

# Run perltidy on perl scripts. Scripts are modified in place. A copy will be
# saved with .bak extension.
# By default, perltidy will look for .perltidyrc current directory (repository
# root) and in the home directory. If no config file is found then perltidy will
# run with --perl-best-practices.

set -eu

# default min-version to "oldest we know about"
# the oldest version on metacpan is 20021130
minversion=20021130

# bash arguments are ... fun
# the following came from https://bl.ocks.org/magnetikonline/22c1eb412daa350eeceee76c97519da8
ARGUMENT_LIST=(
    "min-version"
);
# read arguments
opts=$(getopt \
    --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
    --name "$(basename "$0")" \
    --options "" \
    -- "$@"
)
eval set --$opts
while [[ $# -gt 0 ]]; do
    case "$1" in
        --min-version)
            minversion=$2
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

# check for minversion
if ! perl -MPerl::Tidy=${minversion} -e1 >/dev/null 2>&1; then
    echo "Please update Perl::Tidy to at least verion ${minversion}";
    exit 1;
fi

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
