# PCIe interface has Advance Error reporting which can be used for monitoring to measure errors.

# Basics of lspci
# device get identified by vendor:device id combo which can be seen as output of following command
# in first line of every device within sqare bracket
# example:
# 03:04.0 PCI bridge [0604]: PLX Technology, Inc. Device [10b5:8796] (rev ab) (prog-if 00 [Normal decode])
#        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
#        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
sudo lspci  -nn -vvv -xx



# If device support AER or not can be see through command 

lspci  -vvvv -xxx  -s 03:00.0  | grep -e 'Advanced Error Reporting'
        Capabilities: [fb4 v1] Advanced Error Reporting

# Check the fb4 address that is start address of AER area now add 10 to it which will give you fc4 
# So command to reset flag would be following
# here “.L” means write “LongWord” which is 32-bits (can also do .W/.B which is 16-bits/8-bits).

setpci -s 03:00.0 0xfc4.L=0xffffffff
