TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += RC3USupport

# Compile and add code to the support library
RC3USupport_SRCS += xxxRecord.c
RC3USupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
RC3USupport_SRCS += dbSubExample.c
RC3USupport_SRCS += devRC3UVersion.c
RC3USupport_SRCS += RC3UHello.c
RC3USupport_SRCS += initTrace.c

RC3USupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = RC3UVersion.h
# Macro name
GENVERSIONMACRO = RC3UVERSION

# Build the IOC application
PROD_IOC = RC3U

# RC3U.dbd will be created and installed
DBD += RC3U.dbd

# RC3U.dbd will include these files:
RC3U_DBD += base.dbd
RC3U_DBD += xxxSupport.dbd
RC3U_DBD += dbSubExample.dbd
RC3U_DBD += devRC3UVersion.dbd
RC3U_DBD += RC3UHello.dbd
RC3U_DBD += initTrace.dbd
RC3U_DBD += asyn.dbd
RC3U_DBD += drvAsynSerialPort.dbd
RC3U_DBD += drvAsynIPPort.dbd
RC3U_DBD += calc.dbd
RC3U_DBD += stream-scalcout.dbd
RC3U_DBD += stream.dbd
RC3U_DBD += as.dbd
RC3U_DBD += asSupport.dbd
# RC3U_registerRecordDeviceDriver.cpp derives from RC3U.dbd
RC3U_SRCS += RC3U_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
RC3U_SRCS_DEFAULT += RC3UMain.cpp
RC3U_SRCS_vxWorks += -nil-

# Link in the code from our support library
RC3U_LIBS += RC3USupport
RC3U_LIBS += asyn
RC3U_LIBS += calc
RC3U_LIBS += autosave
RC3U_LIBS += stream
# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into RC3USupport
    sncExample_SNCFLAGS += +r
    RC3U_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    RC3USupport_SRCS += sncExample.stt
    RC3USupport_LIBS += seq pv
    RC3U_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    RC3U_LIBS += qsrv
    RC3U_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    RC3U_DBD += PVAServerRegister.dbd
    RC3U_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
RC3U_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devRC3UVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
