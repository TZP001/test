#
# Specifications for Build step mkBSCORBACompilJavaC
#
METACLASS_NAME = CompilJava_C
METACLASS_SOURCE = Modification_C
#
DGM_GRAPH_PATH = MODDGM_GRAPHPATH_JAVA
CORBA_DGM_GRAPH_PATH = MODDGM_GRAPHPATH_JAVA MODDGM_GRAPHPATH
#
SOURCE_EXTENSION = *.java
#
DEPENDENT_ON = $(MOD_LinkWith)
#
CORBA_JAVA_PACKAGE_CS = $(CORBA_JAVA_PACKAGE:-"com.dassault_systemes")
CORBA_PACKAGE = $(CORBA_JAVA_PACKAGE_C:-CORBA_JAVA_PACKAGE_CS)
#
CORBA_DIRECTORY = tmp.client
#
OBJLIST = .mkobjlist_C.java
#
include mkBSJavaVersion.mk
#
DGM_DEPEND = JAVA_VERSION
#