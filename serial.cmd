

#drvAsynSerialPortConfigure("portName","ttyName",priority,noAutoConnect,noProcessEosIn)
#asynSetOption("portName",addr,"Key","value")

drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB0", 0, 0, 0)
asynSetOption("serial1",0,"baud","9600")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"ixoff","N")
asynSetOption("serial1",0,"ixon","Y")


# Load asyn records on all serial ports
dbLoadTemplate("asynRecord.template")
dbLoadRecords("$(IP)/db/RC3U.db","P=$(PREFIX),PORT=serial1")
