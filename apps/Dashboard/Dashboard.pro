TEMPLATE = app
TARGET = dashboard
QT = quickcontrols2

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    dashboard.qrc \
    images/images.qrc
