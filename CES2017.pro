TEMPLATE = subdirs
SUBDIRS = apps imports

load(configure)
qtCompileTest(libhomescreen)
