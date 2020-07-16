#!/bin/bash

function yes_no  {

        local Q=$1
        echo "$Q : [y/n] "
        read ANS


        if [ $ANS = 'y' -o $ANS = 'Y' -o $ANS = 'yes' -o $ANS = 'Yes' -o $ANS = 'YES' ]
        then
                return 1
        fi

        if [ $ANS = 'n' -o $ANS = 'N' -o $ANS = 'no' -o $ANS = 'No' -o $ANS = 'NO' ]
        then
                return 0
        fi

}


function cmd_wait {
        yes_no 'do you want to continue with the script? '
        if [ $? -eq 0 ]
        then
                exit
        fi
}

trap "set +x; cmd_wait ; set -x" DEBUG



echo 1
echo 2
echo 3
