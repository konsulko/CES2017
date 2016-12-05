TEMPLATE = app
TARGET = radio
QT = quickcontrols2

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    radio.qrc \
    images/images.qrc

