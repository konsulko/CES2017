/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0

MouseArea {
    id: root

    width: 90
    height: 90

    property bool active: false
    property alias source: icon.source

    function click() {
        clicked(undefined)
    }

    Image {
        id: icon
        anchors.centerIn: parent
        width: 100
        height: 100
        fillMode: Image.PreserveAspectFit
    }

//    states: [
//        State {
//            name: "focused"
//            when: root.active
//            PropertyChanges {
//                target: icon
//                scale: 2.0
//                anchors.verticalCenterOffset: 20
//            }
//        }
//    ]

//    transitions: [
//        Transition {
//            NumberAnimation {
//                properties: 'scale, anchors.verticalCenterOffset'
//                easing.type: Easing.OutElastic
//                duration: 500
//            }
//        }
//    ]
}
