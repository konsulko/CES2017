TEMPLATE = app
TARGET = phone
QT = quickcontrols2

config_libhomescreen {
    CONFIG += link_pkgconfig
    PKGCONFIG += homescreen
    DEFINES += HAVE_LIBHOMESCREEN
}

SOURCES = main.cpp

RESOURCES += \
    phone.qrc \
    images/images.qrc

