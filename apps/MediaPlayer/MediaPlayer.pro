TEMPLATE = app
TARGET = mediaplayer
QT = quickcontrols2 multimedia

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    mediaplayer.qrc \
    images/images.qrc

