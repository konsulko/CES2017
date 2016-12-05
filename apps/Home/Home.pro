TEMPLATE = app
TARGET = home
QT = quickcontrols2 dbus

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

HEADERS += \
    applicationmodel.h \
    appinfo.h

SOURCES = main.cpp \
    applicationmodel.cpp \
    appinfo.cpp

RESOURCES += \
    home.qrc \
    images/images.qrc

