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

T.ProgressBar {
    id: control
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        radius: control.height / 2
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        color: "#666666"
    }

    contentItem: Item {
        implicitWidth: background.implicitWidth
        implicitHeight: background.implicitHeight

        Rectangle {
            rotation: -90
            transformOrigin: Item.TopLeft
            y: 10
            width: parent.height
            height: control.visualPosition * background.width
            radius: width / 2
            gradient: Gradient {
                GradientStop { position: 0.0; color: '#59FF7F' }
                GradientStop { position: 1.0; color: '#6BFBFF' }
            }
        }
    }
}
