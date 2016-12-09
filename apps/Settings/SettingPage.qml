/*
 * Copyright (C) 2016 The Qt Company Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import AGL.Demo.Controls 1.0

Page {
    id: root
    readonly property bool isSetting: true
    property string icon
    property bool checkable: false
    property bool checked: false
    function done() {
        parent.pop()
    }

    Connections {
        target: root
        onCheckedChanged: {
            checkedSwitch.checked = checked
        }
    }

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.bottom: parent.top
        anchors.bottomMargin: 10
        spacing: 20

        Switch {
            id: checkedSwitch
            visible: root.checkable
            onCheckedChanged: root.checked = checked
        }

        ImageButton {
            id: back
            anchors.bottom: parent.bottom
            offImage: '../images/HMI_Settings_X.svg'
            onClicked: root.done()
        }
    }

}
