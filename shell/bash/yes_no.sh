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
