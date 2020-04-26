#!/bin/bash


INSTANCE=$1

if [ -z $INSTANCE ]
then
	echo
	echo "Please provide EC2 instance id"
	exit
fi






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

function execute {
    $@
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
	exit 1
    fi
    return $status
}



echo "Starting an instance ${INSTANCE}"
execute aws ec2  start-instances --instance-id  ${INSTANCE}


echo "Waiting for an instance ${INSTANCE} to come up"
sleep 5
while true 
do 
IP=`aws ec2  describe-instances  --instance-id  $INSTANCE | jq .Reservations[0].Instances[0].PublicIpAddress | sed -e 's/"//g'`
if [ "$IP" != "null" ]
then
	break
fi 
done
sleep 20
echo "sshing into the instance ${INSTANCE}"
ssh -o StrictHostKeyChecking=no  -t  $IP


yes_no "do you want to shutdown instance  ${INSTANCE}? "
if [ $? -eq 1 ]
then
	echo "Shutting down the instance"
	aws ec2  stop-instances --instance-id  ${INSTANCE}
else
	echo "Left instance running - execute following command to stop it"
	echo "aws ec2  stop-instances --instance-id  ${INSTANCE}"
fi
