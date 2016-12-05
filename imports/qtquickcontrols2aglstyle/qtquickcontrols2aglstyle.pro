TEMPLATE = aux

DISTFILES = *.qml images

files.files = $$DISTFILES
files.path = $$[QT_INSTALL_QML]/QtQuick/Controls.2/AGL

INSTALLS += files
