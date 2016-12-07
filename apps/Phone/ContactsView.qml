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
import 'models'

Item {
    id: root

    signal call(var contact)
    signal cancel

    ListView {
        anchors.fill: parent
        header: Item {
            width: parent.width
            height: 200
            RowLayout {
                anchors.fill: parent
                anchors.margins: 50
                Label {
                    Layout.fillWidth: true
                    text: 'Contacts'
                }
                ImageButton {
                    offImage: './images/HMI_ContactScreen_X-01.svg'
                    onClicked: root.cancel()
                }
            }
        }
        model: ContactsModel {}
        delegate: MouseArea {
            width: ListView.view.width
            height: width / 5
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 200
                spacing: 20
                Image {
                    source: './images/HMI_ContactScreen_ImageHolder-01.svg'
                }
                ColumnLayout {
                    Label {
                        Layout.fillWidth: true
                        color: '#59FF7F'
                        text: model.name
                    }

                    Label {
                        Layout.fillWidth: true
                        font.pixelSize: 30
                        text: model.number
                    }
                }
            }
            onClicked: {
                root.call(model)
            }
        }
        section.property: 'name'
        section.criteria: ViewSection.FirstCharacter
        section.delegate: Item {
            Label {
                width: root.width / 5
                height: width
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: '#59FF7F'
                text: section
            }
        }
    }
}
