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
import QtMultimedia 5.5
import AGL.Demo.Controls 1.0
import 'models'

Item {
    id: root

    signal showContacts
    function call(contact) {
        name.text = contact.name
        number.text = contact.number
        callButton.checked = true
    }

    ImageButton {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 60
        width: 172
        height: 172
        offImage: './images/HMI_Phone_Contacts-01.svg'
        onClicked: root.showContacts()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 50
        anchors.bottomMargin: 50
        spacing: 20
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Label {
                id: name
                font.pixelSize: 40
                color: '#59FF7F'
            }
            TextField {
                id: number
                readOnly: true
            }
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 3
            columnSpacing: 30
            rowSpacing: 30
            Repeater {
                model: ListModel {
                    ListElement { value: '1'; image: '1' }
                    ListElement { value: '2'; image: '2' }
                    ListElement { value: '3'; image: '3' }
                    ListElement { value: '4'; image: '4' }
                    ListElement { value: '5'; image: '5' }
                    ListElement { value: '6'; image: '6' }
                    ListElement { value: '7'; image: '7' }
                    ListElement { value: '8'; image: '8' }
                    ListElement { value: '9'; image: '9' }
                    ListElement { value: '*'; image: 'asterisk' }
                    ListElement { value: '0'; image: '0' }
                    ListElement { value: '#'; image: 'NumberSign' }
                }
                ImageButton {
                    onImage: './images/HMI_Phone_Button_%1_Active-01.svg'.arg(model.image)
                    offImage: './images/HMI_Phone_Button_%1_Inactive-01.svg'.arg(model.image)
                    onClicked: {
                        number.text += model.value
                    }
                }
            }
        }

        ToggleButton {
            id: callButton
            Layout.alignment: Qt.AlignHCenter
            onImage: './images/HMI_Phone_Hangup.svg'
            offImage: './images/HMI_Phone_Call.svg'

            SoundEffect {
                id: ringtone
                source: './Phone.wav'
                loops: SoundEffect.Infinite
                category: 'phone'
            }

            onCheckedChanged: {
                if (checked) {
                    if (number.text.length === 0) {
                        callButton.checked = false
                        return
                    }

                    var contact = {'name': name.text, 'number': number.text}
                    if (contact.name === '')
                        contact.name = 'Unknown'
                    history.insert(0, contact)
                    ringtone.play()
                } else {
                    name.text = ''
                    number.text = ''
                    ringtone.stop()
                }
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.preferredHeight: 130
            orientation: Qt.Horizontal
            clip: true
            model: CallHistoryModel { id: history }

            delegate: MouseArea {
                width: root.width / 2.5
                height: ListView.view.height
                RowLayout {
                    anchors.fill: parent
                    spacing: 20
                    Image {
                        source: './images/HMI_Phone_Contact_BlankPhoto.svg'
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
                onClicked: root.call(model)
            }
        }
    }
}
