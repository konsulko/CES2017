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
import QtQuick.Window 2.0
import QtQuick.Templates 2.0 as T

T.Button {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    font.family: 'Roboto'
    font.pixelSize: Math.min(Screen.width, Screen.height) / 50

    Translate {
        id: translate
    }

    contentItem: Text {
        text: root.text
        font: root.font
        opacity: enabled ? 1.0 : 0.3
        color: 'white'
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        transform: translate
    }

    background: Image {
        source: root.highlighted ? './images/HMI_Settings_Button_Ok.svg' : './images/HMI_Settings_Button_Cancel.svg'
        transform: translate
    }

    states: [
        State {
            name: 'pressed'
            when: root.pressed
            PropertyChanges {
                target: translate
                x: 3
                y: 3
            }
            PropertyChanges {
                target: background
                opacity: 0.75
            }
        }
    ]
}
