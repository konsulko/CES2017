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

T.Button {
    id: control
    implicitWidth: contentItem.implicitWidth
    implicitHeight: contentItem.implicitHeight

    property url offImage
    property url onImage: offImage

    contentItem: Image {
        source: control.pressed ? control.onImage : control.offImage
        transform: [
            Translate {
                id: translate
            }
        ]
        states: [
            State {
                when: control.pressed
                PropertyChanges {
                    target: translate
                    x: 5
                    y: 5
                }
            }
        ]
    }
}
