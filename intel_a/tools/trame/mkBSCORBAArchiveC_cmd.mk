CORBA_CLIENT_DEFINE = CLIENT
CORBA_SERVER_DEFINE = SERVER
#CORBA_CS_DEFAULT = $(CORBA_CLIENT_DEFINE) $(CORBA_SERVER_DEFINE)
CORBA_CS_DEFAULT = 
CORBA_CS = $(CORBA_JAVA_CS:-CORBA_CS_DEFAULT)
include mkBSArchive_cmd.mk
#
DGM_VERSION = 1.0
#
