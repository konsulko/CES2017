/* Copyright (C) 2015, Jaguar Land Rover, IoT.bzh. All Rights Reserved.
 * Copyright (C) 2016 The Qt Company Ltd.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtMultimedia 5.0

ApplicationWindow {
    id: root

    ListModel {
        id: presetModel
        ListElement {
            frequency: 76100
            title: "Inter FM"
        }
        ListElement {
            frequency: 77100
            title: "The Open University of Japan"
        }
        ListElement {
            frequency: 80000
            title: "TOKYO FM"
        }
        ListElement {
            frequency: 81300
            title: "J-WAVE"
        }
        ListElement {
            frequency: 82500
            title: "NHK FM Tokyo"
        }
    }

    Row {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: root.width / 20
        spacing: root.width / 100
        Image {
            source: './images/Media_Inactive_Icon.png'
        }
        Image {
            source: './images/Radio_Active_Icon.png'
        }
    }

    ColumnLayout {
        anchors.fill: parent
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Image {
                anchors.centerIn: parent
                source: './images/HMI_Radio_Equalizer.png'
            }
            RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: root.width / 20

                Image {
                    source: './images/Radio_Scan-.png'
                }

                Image {
                    source: './images/Radio_Freq-.png'
                }

                Label {
                    Layout.fillWidth: true
                    text: '102.5'
                    font.pixelSize: 150
                    horizontalAlignment: Text.AlignRight
                }
                Label {
                    text: 'MHz'
                    font.pixelSize: 50
                }

                Image {
                    source: './images/Radio_Freq+.png'
                }
                Image {
                    source: './images/Radio_Scan+.png'
                }
            }

        }
        Image {
            source: './images/HMI_Radio_Channel_Slider.png'
        }
    }
}
