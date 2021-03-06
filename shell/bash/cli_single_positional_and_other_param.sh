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



# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_first='arg first default'
_arg_second='arg second default'
_arg_third='arg third default'

print_help ()
{
    printf "%s\n" "<The general help message of my script>"
    printf 'Usage: %s [--first <arg>] [--(no-)second] [--(no-third)] [-h|--help] <positional-arg>\n' "$0"
    printf "\t%s\n" "<positional-arg>: <positional-arg's help message goes here>"
    printf "\t%s\n" "--first: <first arg>  this takes a value"
    printf "\t%s\n" "--second,--no-second: <second arg> (off by default) boolean kind"
    printf "\t%s\n" "--third,--no-third: <third arg> (off by default) boolean kind"
    printf "\t%s\n" "-h,--help: Prints help"

}

parse_commandline ()
{
    while test $# -gt 0
    do
        _key="$1"
        case "$_key" in
            --first)
                test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
                _arg_first="$2"
                shift
                ;;
            --first=*)
                _arg_first="${_key##--first=}"
                ;;
            --no-second|--second)
                _arg_second="on"
                test "${1:0:5}" = "--no-" && _arg_second="off"
                ;;
            --no-third|--third)
                _arg_third="on"
                test "${1:0:5}" = "--no-" && _arg_third="off"
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
                _positionals+=("$1")
                ;;
        esac
        shift
    done
}


handle_passed_args_count ()
{
    _required_args_string="'positional-arg'"
    test ${#_positionals[@]} -lt 1 && _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 1 (namely: $_required_args_string), but got only ${#_positionals[@]}." 1
    test ${#_positionals[@]} -gt 1 && _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 1 (namely: $_required_args_string), but got ${#_positionals[@]} (the last one was: '${_positionals[*]: -1}')." 1
}

assign_positional_args ()
{
    _positional_names=('_arg_positional_arg' )

    for (( ii = 0; ii < ${#_positionals[@]}; ii++))
    do
        eval "${_positional_names[ii]}=\${_positionals[ii]}" || die "Error during argument parsing, possibly an Argbash bug." 1
    done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


echo "--first is $_arg_first"
echo "--second is $_arg_second"
echo "--third is $_arg_third"
echo "Value of positional-arg: $_arg_positional_arg"
