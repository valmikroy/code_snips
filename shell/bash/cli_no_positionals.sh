#!/bin/bash


die()
{
    local _ret=$2
    test -n "$_ret" || _ret=1
    test "$_PRINT_HELP" = yes && print_help >&2
    echo "$1" >&2
    exit ${_ret}
}


_arg_rack='XXX.YYY'
_arg_secondary='off'

print_help ()
{
    printf "%s\n" "<The general help message of my script>"
    printf 'Usage: %s [--rack <arg>] [--(no-)secondary] [-h|--help] <positional-arg>\n' "$0"
    printf "\t%s\n" "<positional-arg>: <positional-arg's help message goes here>"
    printf "\t%s\n" "--rack: <rack arg>  this takes a value"
    printf "\t%s\n" "--secondary,--no-secondary: <secondary arg> (off by default) boolean kind"
    printf "\t%s\n" "-h,--help: Prints help"

}

parse_commandline ()
{
    while test $# -gt 0
    do
        _key="$1"
        case "$_key" in
            --rack)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_rack="$2"
                shift
                ;;
            --rack=*)
                _arg_rack="${_key##--rack=}"
                ;;
            --no-secondary|--secondary)
                _arg_secondary="on"
                test "${1:0:5}" = "--no-" && _arg_secondary="off"
                ;;
            -h|--help)
                print_help
                exit 0
                ;;
            -h*)
                print_help
                exit 0
                ;;
            *)
                print_help
                ;;
        esac
        shift
    done
}




parse_commandline "$@"



echo "--rack is $_arg_rack"
echo "--secondary is $_arg_secondary"

