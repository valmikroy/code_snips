
function execute {
    $@
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
    fi
    return $status
}

# execute "sudo /usr/bin/lscpu"
