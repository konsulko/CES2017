TEMPLATE = subdirs
SUBDIRS = apps

load(configure)
qtCompileTest(libhomescreen)
