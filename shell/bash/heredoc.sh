#!/bin/bash

# The string after '<<' indicates where to stop.
cat << EndOfMessage
This is line 1.
This is line 2.
Line 3.
EndOfMessage



# send to file
cat > /tmp/blah.txt <<- EOM
Line 1.
Line 2.
EOM

# store  multiline  in variable 
read -r -d '' MULTI_LINE_VAR << EOM
This is line 1.
This is line 2.
Line 3.
EOM

echo "$MULTI_LINE_VAR"

# if you need indentation use tabs 

# store  multiline  in variable 
read -r -d '' MULTI_LINE_VAR <<- EOM
  This is line 1.
  This is line 2.
  Line 3.
EOM
