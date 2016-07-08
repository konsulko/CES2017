/* Copyright (C) 2015, Jaguar Land Rover, IoT.bzh. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import system 1.0
import utils 1.0
import components 1.0

App {
    id: root
    appId: "fmradio"

    Radio {
        id: radio
    }

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

    ColumnLayout {
        anchors.fill: parent
        Text {
            id: label
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 1
            property int frequency: radio.frequency
            Behavior on frequency {
                NumberAnimation {
                    duration: 1000
                    easing.type: Easing.OutExpo
                }
            }
            font.pixelSize: 256
            rotation: -30
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            text: (label.frequency / 1000.0).toFixed(1) + " MHz"
        }

        ListView {
            id: presetView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 1
            clip: true
            focus: true
            model: presetModel
            delegate: MouseArea {
                width: ListView.view.width
                height: 100
                Text {
                    id: presetLabel
                    anchors.fill: parent
                    font.pixelSize: 48
                    color: 'white'
                    text: model.title
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: 1.0 - scale / 10.0
                }
                onClicked: {
                    if (radio.frequency === model.frequency) {
                        if (radio.state === Radio.StoppedState)
                            radio.start()
                        else
                            radio.stop()
                    } else {
                        radio.frequency = model.frequency
                        if (radio.state === Radio.StoppedState)
                            radio.start()
                        presetView.currentIndex = model.index
                    }
                }
                states: State {
                    when: radio.frequency === model.frequency
                    name: 'active'
                }
                transitions: Transition {
                    to: 'active'
                    SequentialAnimation {
                        alwaysRunToEnd: true
                        NumberAnimation {
                            target: presetLabel
                            properties: 'scale'
                            to: 10.0
                            easing.type: Easing.OutCubic
                        }

                        PropertyAction {
                            target: presetLabel; property: 'scale'; value: 1.0
                        }
                    }
                }
            }
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 100
            preferredHighlightEnd: 100
            highlight: Rectangle {
                color: '#ff53b5ce'
                opacity: 0.5
            }
        }
    }

    onFocusChanged: {
        if (focus) {
//            radio.start()
        } else {
//            radio.stop()
        }
    }
    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Return:
            if (root.hasKeyFocus) {
                if (radio.frequency === presetModel.get(presetView.currentIndex).frequency) {
                    console.debug(radio.state)
                    if (radio.state === Radio.StoppedState)
                        radio.start()
                    else
                        radio.stop()
                } else {
                    radio.frequency = presetModel.get(presetView.currentIndex).frequency
                    if (radio.state === Radio.StoppedState)
                        radio.start()
                }
                event.accepted = true
            }
            break
        case Qt.Key_PageUp:
            presetView.decrementCurrentIndex()
            event.accepted = true
            break
        case Qt.Key_PageDown:
            presetView.incrementCurrentIndex()
            event.accepterd = true
            break
        default:
            break
        }
    }
    Connections {
        target: presetView
        onCurrentIndexChanged: hasKeyFocus = true
    }
}
