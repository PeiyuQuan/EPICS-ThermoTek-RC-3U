errlogInit(5000)
< envPaths
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in this build from CARS
dbLoadDatabase("../../dbd/iocxxxLinux.dbd")
iocxxxLinux_registerRecordDeviceDriver(pdbbase)

epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(IP)/db")
epicsEnvSet("PREFIX", "SLAC:RC3U:")
epicsEnvSet("PORT", "serial1")


################################################################################


### Scan-support software
# crate-resident scan.  This executes 1D, 2D, 3D, and 4D scans, and caches
# 1D data, but it doesn't store anything to disk.  (You need the data catcher
# or the equivalent for that.)  This database is configured to use the
# "alldone" database (above) to figure out when motors have stopped moving
# and it's time to trigger detectors.

< serial.cmd
asynSetTraceIOMask("serial1",0,2)
asynSetTraceMask("serial1",0,9)


dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:RC3U:")
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")


iocInit

