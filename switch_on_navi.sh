#!/bin/sh
# this script would be called from QML demo UI when a button of map is clicked

if [ $AGL_NAVI = "TRUE" ]; then
  export XDG_RUNTIME_DIR=/run/user/0
  /usr/bin/LayerManagerControl set layer 1000 render order $SURFACE_ID_QMLSCENE,$SURFACE_ID_NAVI
fi
