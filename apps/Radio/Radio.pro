TEMPLATE = app
TARGET = radio
QT = quick dbus

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    radio.qrc \
    images/images.qrc

