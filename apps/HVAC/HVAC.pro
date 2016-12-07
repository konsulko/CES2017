TEMPLATE = app
TARGET = hvac
QT = quickcontrols2

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    hvac.qrc \
    images/images.qrc

