#!/usr/bin/env bash

function die {
        local _ret=$2
        test -n "$_ret" || _ret=1
        test "$_PRINT_HELP" = yes && print_help >&2
        echo "$1" >&2
        exit ${_ret}
}



_positionals=()

# default argument to script
_arg_input_argument="my_default_positional_argument"

function print_help {
        printf '\n'
        printf '%s\n' "The general script's help msg"
        printf 'Usage: %s <disk_model>\n' "$0"
        printf '\t%s\n' "<disk_model>: The argument with a default (default: 'my_default_positional_argument - default')"
        printf '\n'
}

function parse_commandline {
        while test $# -gt 0
        do
                _key="$1"
                case "$_key" in
                        -h|--help)
                                print_help
                                exit 0
                                ;;
                        -h*)
                                print_help
                                exit 0
                                ;;
                        *)

                                test -z $_positionals && _positionals="$1" || die "ERROR: script can not take more than one argument" 1
                                ;;
                esac
                shift
        done
}



parse_commandline "$@"
test -z $_positionals && _positionals=$_arg_input_argument

# arg parsing done

echo "Value of single positional argument: $_positionals"
