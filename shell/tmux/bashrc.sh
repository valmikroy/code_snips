function _tls {
        tmux ls
}

function _tnew {
        tmux new -s $1
}

function _tattach {
        tmux attach -d -t $1
}

function assh {

        if [ -z $TMUX ]
        then
                command ssh -A "$@"
        else
                tmux rename-window "$(echo $* | cut -d . -f 1)"
                command ssh -o ForwardAgent=yes  -o StrictHostKeyChecking=no -o BatchMode=yes  "$@"
                tmux set-window-option automatic-rename "on" 1>/dev/null
        fi

}
