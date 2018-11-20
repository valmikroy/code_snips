#!/bin/bash

die()
{
        local _ret=$2
        test -n "$_ret" || _ret=1
        test "$_PRINT_HELP" = yes && print_help >&2
        echo "$1" >&2
        exit ${_ret}
}

begins_with_short_option()
{
        local first_option all_short_options
        all_short_options='h'
        first_option="${1:0:1}"
        test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}



_positionals=()

# default argument to script
_arg_input_argument="my_default_positional_argument"

print_help ()
{
        printf '\n'
        printf '%s\n' "The general script's help msg"
        printf 'Usage: %s <my_input_argument>\n' "$0"
        printf '\t%s\n' "<my_input_argument>: The argument with a default (default: 'my_default_positional_argument - default')"
        printf '\n'
}

parse_commandline ()
{
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
