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
import '..'

SettingPage {
    id: root
    icon: '/example/images/HMI_Settings_Example.svg'
    title: 'Example'
    checkable: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 100
        RowLayout {
            spacing: 20
            Button {
                text: 'Sushi'
                highlighted: true
            }
            Button {
                text: 'Sashimi'
            }
            Button {
                text: 'Ramen'
            }
        }

        Image {
            source: '../images/HMI_Settings_DividingLine.svg'
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: 10
            delegate: MouseArea {
                width: ListView.view.width
                height: 110
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 30
                    Image {
                        source: './images/HMI_Settings_Example.svg'
                    }

                    ColumnLayout {
                        Label {
                            id: title
                            Layout.fillWidth: true
                            text: 'Title'
                            font.pixelSize: 48
                        }
                        Label {
                            id: subtitle
                            Layout.fillWidth: true
                            text: 'Subtitle'
                            color: '#66FF99'
                            font.pixelSize: 24
                        }
                    }

                    Button {
                        text: 'Go'
                    }
                }

                Image {
                    source: '../images/HMI_Settings_DividingLine.svg'
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    visible: model.index > 0
                }
            }
        }
    }
}
