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

ApplicationWindow {
    id: root

    Radio {
        id: radio
        property string title
        onBandChanged: frequency = minimumFrequency
        onStationFound: title = stationId
        onFrequencyChanged: {
            title = ''
            slider.value = frequency
        }

        function freq2str(freq) {
            if (freq > 5000000) {
                return '%1 MHz'.arg((freq / 1000000).toFixed(1))
            } else {
                return '%1 kHz'.arg((freq / 1000).toFixed(0))
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 3
            clip: true
            Image {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                fillMode: Image.PreserveAspectFit
                source: './images/HMI_Radio_Equalizer.svg'
            }
            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height :307
                Rectangle {
                    anchors.fill: parent
                    color: 'black'
                    opacity: 0.75
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: root.width * 0.02
                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Row {
                            spacing: 20
                            ToggleButton {
                                offImage: './images/FM_Icons_FM.svg'
                                onImage: './images/FM_Icons_AM.svg'
                                onCheckedChanged: {
                                    radio.band = checked ? Radio.AM : Radio.FM
                                    radio.frequency = radio.minimumFrequency
                                }
                            }
                        }
                        ColumnLayout {
                            anchors.fill: parent
                            Label {
                                id: label
                                Layout.alignment: Layout.Center
                                text: radio.freq2str(radio.frequency)
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                            }
                            Label {
                                id: artist
                                Layout.alignment: Layout.Center
                                text: radio.title
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                font.pixelSize: label.font.pixelSize * 0.6
                            }
                        }
                    }
                    Slider {
                        id: slider
                        Layout.fillWidth: true
                        from: radio.minimumFrequency
                        to: radio.maximumFrequency
                        stepSize: radio.frequencyStep
                        snapMode: Slider.SnapOnRelease
                        onValueChanged: radio.frequency = value
                        Label {
                            anchors.left: parent.left
                            anchors.bottom: parent.top
                            font.pixelSize: 32
                            text: radio.freq2str(radio.minimumFrequency)
                        }
                        Label {
                            anchors.right: parent.right
                            anchors.bottom: parent.top
                            font.pixelSize: 32
                            text: radio.freq2str(radio.maximumFrequency)
                        }
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Item { Layout.fillWidth: true }
                        ImageButton {
                            offImage: './images/AGL_MediaPlayer_BackArrow.svg'
                            Timer {
                                running: parent.pressed
                                triggeredOnStart: true
                                interval: 100
                                repeat: true
                                onTriggered: radio.tuneDown()
                            }
                        }
                        ImageButton {
                            id: play
                            offImage: './images/AGL_MediaPlayer_Player_Play.svg'
                            onClicked: radio.start()
                            states: [
                                State {
                                    when: radio.state === Radio.ActiveState
                                    PropertyChanges {
                                        target: play
                                        offImage: './images/AGL_MediaPlayer_Player_Pause.svg'
                                        onClicked: radio.stop()
                                    }
                                }
                            ]
                        }
                        ImageButton {
                            offImage: './images/AGL_MediaPlayer_ForwardArrow.svg'
                            Timer {
                                running: parent.pressed
                                triggeredOnStart: true
                                interval: 100
                                repeat: true
                                onTriggered: radio.tuneUp()
                            }
                        }

                        Item { Layout.fillWidth: true }
                    }
                }
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 2
            ListView {
                anchors.fill: parent
                anchors.leftMargin: 50
                anchors.rightMargin: 50
                clip: true
                header: Label { text: 'PRESETS'; opacity: 0.5 }
                model: ListModel {
                    ListElement {
                        title: 'Inter FM'
                        band: Radio.FM
                        frequency: 76100000
                    }

                }
                delegate: MouseArea {
                    width: ListView.view.width
                    height: ListView.view.height / 4

                    onClicked: {
                        radio.band = model.band
                        radio.frequency = model.frequency
                        radio.title = model.title
                    }

                    RowLayout {
                        anchors.fill: parent
                        Image {
                            source: './images/Radio_Active_Icon.svg'
                        }
                        ColumnLayout {
                            Layout.fillWidth: true
                            Label {
                                Layout.fillWidth: true
                                text: model.title
                            }
                            Label {
                                Layout.fillWidth: true
                                text: radio.freq2str(model.frequency)
                                color: '#59FF7F'
                                font.pixelSize: 32
                            }
                        }
                        Image {
                            source: {
                                switch (model.band) {
                                case Radio.FM:
                                    return './images/FM_Icons_FM.svg'
                                case Radio.AM:
                                    return './images/FM_Icons_AM.svg'
                                }
                                return null
                            }
                        }
                    }
                }
            }
        }
    }
}
