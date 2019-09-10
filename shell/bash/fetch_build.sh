#!/bin/bash

HOST=$1
MAC=''

function is_valid_host {
        local HOST=$1

        local invalid_hostname=1

        if [[ $HOST =~ "tran" ]]
        then
                invalid_hostname=0
                MAC=${HOST:10:6}
        fi

        if [[ $HOST =~ "tran-blah" ]]
        then
                invalid_hostname=0
                MAC=${HOST:18:6}
        fi

        if [[ $HOST =~ "tran-wha" ]]
        then
                invalid_hostname=1
        fi

        if [[ $HOST =~ "tran-key" ]]
        then
                invalid_hostname=1
        fi


        if [ $invalid_hostname -gt 0 ]
        then
                echo "$HOST is not valid Kontron hostname"
                exit 1
        else
                MAC=`echo "000000${MAC}" | sed 's/\(..\)/\1:/g;s/:$//'`
        fi

}

function fetch_buildsheet {
        local MAC=$1
        local OUT=`curl -s https://buildsheet/find/${MAC}`

        local ERROR=`echo $OUT | jq .Error`

        if [ "$ERROR" == "null" ]
        then
                echo $OUT
        else
                echo "Buildsheet record dose not present"
                exit 1
        fi

}



if [ -z $HOST ]
then
        echo "Provide tran host"
        exit 1
else
        is_valid_host $HOST
fi


BUILD_SHEET=`fetch_buildsheet $MAC`


cat  <<EOF
---
host: $HOST
location:
        pop: `echo $BUILD_SHEET | jq .pop | sed 's/"//g'`
        rack: `echo $BUILD_SHEET | jq .rack | sed 's/"//g'`
        rack_unit: `echo $BUILD_SHEET | jq .rack_unit | sed 's/"//g'`
serials:
        serial_number: `echo $BUILD_SHEET | jq .serial_number|  sed 's/"//g'`
        chassis_serial_number: `echo $BUILD_SHEET | jq .chassis_serial_number|  sed 's/"//g'`
        hubnode_1_serial_number: `echo $BUILD_SHEET | jq .hubnode_1_serial_number|  sed 's/"//g'`
        hubnode_2_serial_number: `echo $BUILD_SHEET | jq .hubnode_2_serial_number|  sed 's/"//g'`
macs:
        bmc_mac: `echo $BUILD_SHEET | jq  .mac_addresses[4].mac | sed 's/"//g'`
        data_mac: $MAC

EOF
