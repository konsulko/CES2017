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

    property int year: yearControl.model[yearControl.currentIndex]
    property int month: monthControl.currentIndex + 1
    property int day: dayControl.currentIndex + 1

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Up.svg'
        onClicked: monthControl.currentIndex++
    }
    Tumbler {
        id: monthControl
        implicitWidth: 200
        model: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']
        onCurrentIndexChanged: dayControl.regenerateModel()

        EditSeparator { anchors.fill: parent }
    }
    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Down.svg'
        onClicked: monthControl.currentIndex--
    }

    Item { width: 10; height: 10 }
    Label { text: ':' }
    Item { width: 10; height: 10 }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Up.svg'
        onClicked: dayControl.currentIndex++
    }

    Tumbler {
        id: dayControl
        model: ListModel{
            id: monthModel
        }
        Component.onCompleted: regenerateModel()
        function regenerateModel() {
            var eom = 0
            var y = yearControl.model[yearControl.currentIndex]
            var m = monthControl.currentIndex + 1
            switch (m) {
            case 2:
                eom = 28 + parseInt(1 / (y % 4 + 1)) - parseInt(1 - 1 / (y % 100 + 1)) + parseInt(1 / (y % 400 + 1))
                break
            case 4:
            case 6:
            case 9:
            case 11:
                eom = 30
                break
            default:
                eom = 31
                break
            }
            while (monthModel.count < eom)
                monthModel.append({modelData: monthModel.count + 1})
            while (monthModel.count > eom)
                monthModel.remove(monthModel.count - 1, 1)
        }
        EditSeparator { anchors.fill: parent }
    }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Down.svg'
        onClicked: dayControl.currentIndex--
    }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Up.svg'
        onClicked: yearControl.currentIndex++
    }

    Tumbler {
        id: yearControl
        Component.onCompleted: {
            var arr = new Array
            for (var i = 2010; i < 2050; i++) {
                arr.push(i)
            }
            yearControl.model = arr
        }
        onCurrentIndexChanged: dayControl.regenerateModel()
        EditSeparator { anchors.fill: parent }
    }

    ImageButton {
        Layout.alignment: Layout.Center
        offImage: './images/HMI_Settings_TimeDate_Arrow_Down.svg'
        onClicked: yearControl.currentIndex--
    }
}
