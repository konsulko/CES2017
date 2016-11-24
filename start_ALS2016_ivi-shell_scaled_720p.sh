#!/bin/sh

AGL_NAVI=FALSE
export AGL_NAVI

#the following value shall be modified for your display side
SCREEN_W=720
SCREEN_H=1280

#Demo is configured to FullHD
QT_W=720
QT_H=1280

#To cut off window title bar.
WIN_TITLE_H=30

#invoke demo apps
systemctl restart weston
sleep 2

DEMO_IMPORTS='-I dummyimports -I imports'
MAIN_QML=Scaled_720p.qml

LD_PRELOAD=/usr/lib/libEGL.so /usr/bin/qt5/qmlscene $DEMO_IMPORTS $MAIN_QML &

# qmlscene create 2 surfaces
#   0x80000000 : for off screen buffer ?
#   0x80000001 : visible
#
SURFACE_ID_QML=0x80000001

#
# layer-add-surfaces wait till 2 surfaces are created.
#
layer-add-surfaces 1000 2

/usr/bin/LayerManagerControl set surface $SURFACE_ID_QML destination region 0 0 $SCREEN_W $SCREEN_H
/usr/bin/LayerManagerControl set surface $SURFACE_ID_QML source region 0 $WIN_TITLE_H $QT_W $QT_H
/usr/bin/LayerManagerControl set layer 1000 render order $SURFACE_ID_QML
/usr/bin/LayerManagerControl set surfaces $SURFACE_ID_QML input focus keyboard
/usr/bin/LayerManagerControl set screen 0 render order 1000
