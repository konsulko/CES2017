TEMPLATE = app
TARGET = mixer
QT += qml quick quickcontrols2

config_libhomescreen {
CONFIG += link_pkgconfig
PKGCONFIG += homescreen
DEFINES += HAVE_LIBHOMESCREEN
}

HEADERS = model.h
SOURCES = main.cpp \
	  model.cpp \
	  pac.c
LIBS = -lpulse

RESOURCES += Mixer.qrc \
	     images/images.qrc
