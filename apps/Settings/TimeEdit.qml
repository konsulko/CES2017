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
