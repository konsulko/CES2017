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

ApplicationWindow {
    id: root

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: settings
    }

    Page {
        id: settings
        title: 'Settings'
        ListView {
            anchors.fill: parent
            anchors.margins: root.width * 0.075
            clip: true
            model: ListModel {
                ListElement {
                    icon: 'qrc:/images/HMI_Settings_TimeIcon.svg'
                    name: 'Date & Time'
                    togglable: false
                    app: 'DateTime.qml'
                }
                ListElement {
                    icon: 'qrc:/images/HMI_Settings_BluetoothIcon.svg'
                    name: 'Bluetooth'
                    togglable: true
                    app: 'Bluetooth.qml'
                }
                ListElement {
                    icon: 'qrc:/images/HMI_Settings_WifiIcon.svg'
                    name: 'Wifi'
                    togglable: true
                    app: 'Wifi.qml'
                }
            }

            delegate: MouseArea {
                id: delegate
                width: ListView.view.width
                height: width / 6
                RowLayout {
                    anchors.fill: parent
                    Image {
                        source: model.icon
                    }
                    Label {
                        Layout.fillWidth: true
                        text: model.name.toUpperCase()
                        color: '#59FF7F'
                    }
                    Switch {
                        visible: model.togglable
                    }
                }
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: 1
                    color: 'white'
                    opacity: 0.25
                    visible: model.index > 0
                }

                onClicked: {
                    var component = Qt.createComponent(model.app)
                    stack.push(component, {'stack': stack})
                }
            }
        }
    }
}
