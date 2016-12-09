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
import AGL.Demo.Controls 1.0

GridLayout {
    id: root
    flow: GridLayout.TopToBottom
    rows: 3

    property int hour: hourControl.currentIndex
    property int minutes: minutesControl.currentIndex
    property string ampm: ampmControl.model[ampmControl.currentIndex]

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Up.svg'
        onClicked: hourControl.currentIndex++
    }
    Tumbler {
        id: hourControl
        model: 12
        EditSeparator { anchors.fill: parent }
    }
    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Down.svg'
        onClicked: hourControl.currentIndex--
    }

    Item { width: 10; height: 10 }
    Label { text: ':' }
    Item { width: 10; height: 10 }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Up.svg'
        onClicked: minutesControl.currentIndex++
    }

    Tumbler {
        id: minutesControl
        model: 60
        EditSeparator { anchors.fill: parent }
    }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Down.svg'
        onClicked: minutesControl.currentIndex--
    }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Up.svg'
        onClicked: ampmControl.currentIndex++
    }

    Tumbler {
        id: ampmControl
        model: ['AM', 'PM', 'AM', 'PM']
        EditSeparator { anchors.fill: parent }
    }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Down.svg'
        onClicked: ampmControl.currentIndex--
    }
}
