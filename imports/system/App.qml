/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
 
import QtQuick 2.0
import system 1.0

FocusScope {
    id: root
    property string appId
    anchors.fill: parent
    visible: System.activeApp === appId
    property bool hasKeyFocus: false
    focus: visible
    onFocusChanged: if (focus) hasKeyFocus = true

    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Left:
        case Qt.Key_Right:
            root.hasKeyFocus = false
            break
        default:
            break
        }
    }
}
