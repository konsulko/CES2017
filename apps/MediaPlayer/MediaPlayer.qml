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
                source: './images/AGL_MediaPlayer_AlbumArtwork.svg'
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
                                offImage: './images/AGL_MediaPlayer_Shuffle_Inactive.svg'
                                onImage: './images/AGL_MediaPlayer_Shuffle_Active.svg'
                            }
                            ToggleButton {
                                offImage: './images/AGL_MediaPlayer_Loop_Inactive.svg'
                                onImage: './images/AGL_MediaPlayer_Loop_Active.svg'
                            }
                        }
                        ColumnLayout {
                            anchors.fill: parent
                            Label {
                                id: title
                                Layout.alignment: Layout.Center
                                text: 'Come Together'
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                            }
                            Label {
                                id: artist
                                Layout.alignment: Layout.Center
                                text: 'The Beatles'
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                font.pixelSize: title.font.pixelSize * 0.6
                            }
                        }
                    }
                    Slider {
                        Layout.fillWidth: true
                        value: 132 / 259
                        Label {
                            id: position
                            anchors.left: parent.left
                            anchors.bottom: parent.top
                            font.pixelSize: 32
                            text: '02:12'
                        }
                        Label {
                            id: duration
                            anchors.right: parent.right
                            anchors.bottom: parent.top
                            font.pixelSize: 32
                            text: '04:19'
                        }
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Image {
                            source: './images/AGL_MediaPlayer_Playlist_Inactive.svg'
                        }
                        Image {
                            source: './images/AGL_MediaPlayer_CD_Inactive.svg'
                        }
                        Item { Layout.fillWidth: true }
                        ImageButton {
                            offImage: './images/AGL_MediaPlayer_BackArrow.svg'
                        }
                        ImageButton {
                            offImage: './images/AGL_MediaPlayer_Player_Play.svg'
                        }
                        ImageButton {
                            offImage: './images/AGL_MediaPlayer_ForwardArrow.svg'
                        }

                        Item { Layout.fillWidth: true }
                        Image {
                            source: './images/AGL_MediaPlayer_Bluetooth_Inactive.svg'
                        }
                        Image {
                            source: './images/AGL_MediaPlayer_Radio_Inactive.svg'
                        }
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
                header: Label { text: 'PLAYLIST'; opacity: 0.5 }
                model: ListModel {
                    ListElement {
                        title: 'Something'
                        artist: 'The Beatles'
                        duration: '3:03'
                    }
                    ListElement {
                        title: 'Further Thing'
                        artist: 'The Beatles'
                        duration: '3:23'
                    }
                    ListElement {
                        title: 'Here Comes the Sun'
                        artist: 'The Beatles'
                        duration: '3:06'
                    }
                    ListElement {
                        title: 'Octopus\'s Garden'
                        artist: 'The Beatles'
                        duration: '3:03'
                    }
                }
                delegate: MouseArea {
                    width: ListView.view.width
                    height: ListView.view.height / 4
                    RowLayout {
                        anchors.fill: parent
                        Image {
                            source: './images/AGL_MediaPlayer_Player_Play.svg'
                        }
                        ColumnLayout {
                            Layout.fillWidth: true
                            Label {
                                Layout.fillWidth: true
                                text: model.title
                            }
                            Label {
                                Layout.fillWidth: true
                                text: model.artist
                                color: '#59FF7F'
                                font.pixelSize: 32
                            }
                        }
                        Label {
                            text: model.duration
                            color: '#59FF7F'
                            font.pixelSize: 32
                        }
                    }
                }
            }
        }
    }
}
