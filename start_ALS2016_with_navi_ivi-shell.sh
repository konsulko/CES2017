#!/bin/sh

AGL_NAVI=TRUE
export AGL_NAVI

# The following value shall be modified for your display resolution
SCREEN_W=1080
SCREEN_H=1920

# Demo is configured to FullHD
QT_W=1080
QT_H=1920

# Map data for Navigation
export NAVI_DATA_DIR=/home/root/navi_data/japan_TR9
NAVI_APP=/usr/bin/navi

# surface IDs. This is automatically assigned by wl-shell-emulator.so
# from base 2147483648(0x80000000) and incremented.
#
# This expects navi application will create wl_surface faster than qmlscene.
#
# 3 surfaces are created
#     0x80000000 : navi
#     0x80000001 : qmlscene (for off-screen buffer?)
#     0x80000002 : qmlscene
#
SURFACE_ID_NAVI=0x80000000
SURFACE_ID_QMLSCENE=0x80000002
export SURFACE_ID_NAVI
export SURFACE_ID_QMLSCENE

# Layer ID to contain applicatons
LAYER_ID=1000

# To cut off window title bar.
WIN_TITLE_H=30

# Reboot weston for clean up
systemctl restart weston
sleep 4

# Invoke Demo applications
export XDG_RUNTIME_DIR=/run/user/0

DEMO_IMPORTS='-I dummyimports -I imports'
MAIN_QML=Main.qml

${NAVI_APP} &
LD_PRELOAD=/usr/lib/libEGL.so /usr/bin/qt5/qmlscene $DEMO_IMPORTS $MAIN_QML &

#
# layer-add-surfaces waits until 3 surfaces are created.
#
layer-add-surfaces $LAYER_ID 3

/usr/bin/LayerManagerControl set surface $SURFACE_ID_QMLSCENE destination region 0 0 $SCREEN_W $SCREEN_H
/usr/bin/LayerManagerControl set surface $SURFACE_ID_QMLSCENE source region 0 $WIN_TITLE_H $QT_W $QT_H

# Set offset to position of navi
/usr/bin/LayerManagerControl set surface $SURFACE_ID_NAVI position 0 120

# Explicitly set the surface order to avoid QML screen frozen when launch
/usr/bin/LayerManagerControl set layer 1000 render order $SURFACE_ID_QMLSCENE

/usr/bin/LayerManagerControl set surfaces $SURFACE_ID_QMLSCENE input focus keyboard
/usr/bin/LayerManagerControl set screen 0 render order 1000
