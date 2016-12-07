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

T.Slider {
    id: control
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 50
        radius: control.height / 2
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        color: "#666666"

        Rectangle {
            rotation: -90
            transformOrigin: Item.TopLeft
            y: parent.implicitHeight
            width: parent.height
            height: handle.x + handle.width
            radius: width / 2
            gradient: Gradient {
                GradientStop { position: 0.0; color: '#59FF7F' }
                GradientStop { position: 1.0; color: '#6BFBFF' }
            }
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: implicitHeight
        implicitHeight: control.implicitHeight
        radius: implicitHeight / 2
        color: control.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }
}
