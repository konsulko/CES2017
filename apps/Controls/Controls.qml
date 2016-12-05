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

ApplicationWindow {
    id: root

    GridLayout {
        anchors.fill: parent
        anchors.margins: root.width / 10
        columns: 2

        Label { text: 'Label:' }
        Label {
            text: 'This is a label'
        }

        Label { text: 'Button:' }
        Button {
            text: 'This is a button'
        }

        Label { text: 'Switch:' }
        Switch {}

        Label { text: 'Progress Bar:' }
        ProgressBar {
            NumberAnimation on value {
                from: 0
                to: 1
                duration: 5000
                loops: Animation.Infinite
                easing.type: Easing.SineCurve
            }
        }

        Label { text: 'Slider:' }
        Slider {}
    }
}
