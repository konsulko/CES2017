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

ApplicationWindow {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: width / 10
        anchors.bottomMargin: width / 10
        RowLayout {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            Image {
                source: './images/HMI_HVAC_Fan_Icon.svg'
            }
            Item {
                width: root.width * 0.8
                Slider {
                    id: fanSpeed
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    anchors.left: fanSpeed.left
                    anchors.top: fanSpeed.bottom
                    text: 'FAN SPEED'
                }
            }
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            ColumnLayout {
                Image {
                    source: './images/HMI_HVAC_LeftChair_Section.svg'
                }
            }
            ColumnLayout {
                Layout.fillWidth: true
                spacing: root.width / 40
                ToggleButton {
                    onImage: './images/HMI_HVAC_AC_Active.svg'
                    offImage: './images/HMI_HVAC_AC_Inactive.svg'
                }
                ToggleButton {
                    onImage: './images/HMI_HVAC_Auto_Active.svg'
                    offImage: './images/HMI_HVAC_Auto_Inactive.svg'
                }
                ToggleButton {
                    onImage: './images/HMI_HVAC_Circulation_Active.svg'
                    offImage: './images/HMI_HVAC_Circulation_Inactive.svg'
                }
            }

            ColumnLayout {
                Image {
                    source: './images/HMI_HVAC_RightChair_Section.svg'
                }
            }
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            spacing: root.width / 20
            Repeater {
                model: ['AirDown', 'AirUp', 'AirRight', 'Rear', 'Front']
                ToggleButton {
                    onImage: './images/HMI_HVAC_%1_Active.svg'.arg(model.modelData)
                    offImage: './images/HMI_HVAC_%1_Inactive.svg'.arg(model.modelData)
                }
            }
        }
    }
}
