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

Page {
    id: root
    title: 'Settings'
    property alias model: view.model
    signal launch(var app)
    signal toggled(var app, bool on)
    ListView {
        id: view
        anchors.fill: parent
        anchors.margins: root.width * 0.075
        clip: true
        
        delegate: MouseArea {
            id: delegate
            width: ListView.view.width
            height: width / 6
            RowLayout {
                anchors.fill: parent
                Item {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    Image {
                        anchors.centerIn: parent
                        source: model.icon
                    }
                }
                Label {
                    Layout.fillWidth: true
                    text: model.title.toUpperCase()
                    color: '#59FF7F'
                }
                Switch {
                    id: checkedSwitch
                    visible: model.checkable
                    onCheckedChanged: model.app.checked = checked
                }
                Connections {
                    target: model.app
                    onCheckableChanged: {
                        checkedSwitch.visible = model.app.checkable
                    }
                    onCheckedChanged: {
                        checkedSwitch.checked = model.app.checked
                    }
                }
            }
            Image {
                source: '../images/HMI_Settings_DividingLine.svg'
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                visible: model.index > 0
            }

            onClicked: launch(model.app)
        }
    }
}
