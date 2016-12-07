import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import AGL.Demo.Controls 1.0

Page {
    id: root
    title: 'Date & Time'

    property StackView stack

    ImageButton {
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.bottom: parent.top
        anchors.bottomMargin: 10
        offImage: './images/HMI_Settings_X.svg'
        onClicked: root.stack.pop()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 100
        Label { text: 'Date'}
        DateEdit {}
        Image {
            source: './images/HMI_Settings_DividingLine.svg'
        }
        Label { text: 'Time'}
        TimeEdit {}
        RowLayout {
            anchors.right: parent.right
            Button {
                text: 'OK'
                onClicked: root.stack.pop()
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
