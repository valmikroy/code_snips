while IFS= read -r line
do

  echo $line

done < <(cat $FILE | grep blah)




#Mutiline var read

read -r -d '' HOST_LIST <<EOF
one
two
three
four
EOF




for H in $HOST_LIST
do

        echo $H
done
