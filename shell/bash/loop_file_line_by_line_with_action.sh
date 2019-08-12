while IFS= read -r line
do

  echo $line

done < <(cat $FILE | grep blah)
