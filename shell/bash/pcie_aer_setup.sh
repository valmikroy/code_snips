# PCIe interface has Advance Error reporting which can be used for monitoring to measure errors.

# If device support AER or not can be see through command 

lspci  -vvvv -xxx  -s 03:00.0  | grep -e 'Advanced Error Reporting'
        Capabilities: [fb4 v1] Advanced Error Reporting

# Check the fb4 address that is start address of AER area now add 10 to it which will give you fc4 
# So command to reset flag would be 

setpci -s 03:00.0 0xfc4.L=0xffffffff
