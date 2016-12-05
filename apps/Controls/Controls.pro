TEMPLATE = app
TARGET = controls
QT = quick quickcontrols2

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    controls.qrc \
    images/images.qrc

