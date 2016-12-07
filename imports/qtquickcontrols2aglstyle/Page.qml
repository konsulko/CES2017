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
import QtQuick.Templates 2.0 as T

T.Page {
    id: root

    Item {
        id: headerItem
        height: 200
        opacity: 0.0
        Label {
            id: text
            text: root.title.toUpperCase()
            anchors.left: bar.left
            anchors.bottom: bar.top
        }
        Rectangle {
            id: bar
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            width: root.width * 0.85
            height: 1
            color: 'white'
        }
    }
    states: [
        State {
            when: root.title.length > 0
            PropertyChanges {
                target: root
                header: headerItem
            }
            PropertyChanges {
                target: headerItem
                opacity: 0.5
            }
        }
    ]

    contentItem: Item {}
    background: Item {}
}
