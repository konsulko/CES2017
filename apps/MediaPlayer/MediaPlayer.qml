/* Copyright (C) 2015, Jaguar Land Rover. All Rights Reserved.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import QtMultimedia 5.0
import utils 1.0
import system 1.0

App {
    appId: "media_player"
    width: 1080

    Column {
        id: col
        anchors.top: parent.top
        anchors.topMargin: 100
        width: parent.width
        spacing: 60

        Row {
            spacing: 30

            Rectangle {
                height: label.height
                width: 200
                color: Style.orangeViv
            }

            Text {
                id: label

                color: Style.orangeViv
                font.pixelSize: 20
                text: "MEDIA MANAGER"
            }
        }

        Rectangle {
            width: parent.width
            height: 2
            color: Style.blueViv
        }

        Player {
            id: player
            anchors.horizontalCenter: parent.horizontalCenter
            source: songsList.file
            albumart: songsList.image
            onSend: songsList.listControl(cmd)
        }

        Rectangle {
            width: parent.width
            height: 2
            color: Style.blueViv
        }
    }

    SongsList {
        id: songsList
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: col.bottom
        anchors.topMargin: 58
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        clip: true
        onClicked: player.play()
        focus: true
        onCurrentIndexChanged: dirty = true
    }

    property bool dirty: false
    onDirtyChanged: hasKeyFocus = true
    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_PageUp:
            songsList.decrementCurrentIndex()
            root.dirty = true
            event.accepted = true
            break
        case Qt.Key_PageDown:
            songsList.incrementCurrentIndex()
            root.dirty = true
            event.accepterd = true
            break
        case Qt.Key_Return:
            if (hasKeyFocus) {
                if (player.playbackState === MediaPlayer.PlayingState)
                    player.stop()
                if (dirty) {
                    dirty = false
                    player.play()
                }
                event.accepterd = true
            }
            break
        default:
            break
        }
    }
}
