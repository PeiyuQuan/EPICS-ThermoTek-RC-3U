#!../../bin/linux-x86_64/RC3U

#- You may have to change RC3U to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/RC3U.dbd"
RC3U_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/RC3UApp/Db")
epicsEnvSet ("PREFIX", "SLAC:RC3U:")
epicsEnvSet ("PORT", "serial1")
## Load record instances
#drvAsynIPPortConfigure("serial1", "192.168.0.35:4008<192.168.0.0.35:4008/> COM", 0, 0, 0)
drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","9600")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"crtscts","N")
asynSetOption("serial1",0,"ixon","Y")

asynSetTraceIOMask("serial1",0,"ESCAPE")
asynSetTraceMask("serial1",0,"ERROR|FLOW|DRIVER")


dbLoadRecords("${TOP}/RC3UApp/Db/RC3U.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords("${TOP}/RC3UApp/Db/RC3U-1.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:RC3U:")
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")



cd "${TOP}/iocBoot/${IOC}"
iocInit


