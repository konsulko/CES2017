import QtQuick 2.6
import QtQuick.Layouts 1.1

ColumnLayout {
    anchors.fill: parent
    z: -1
    Item {
        Layout.fillHeight: true
        Layout.preferredHeight: 1
    }
    Repeater {
        model: 2
        Image {
            Layout.fillHeight: true
            Layout.preferredHeight: 2
            Layout.alignment: Layout.Center
            source: './images/HMI_Settings_TimeDate_Arrow_DividingLine.svg'
        }
    }
    Item {
        Layout.fillHeight: true
        Layout.preferredHeight: 1
    }
}
