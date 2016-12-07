import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

Page {
    id: root
    title: 'Date & Time'

    property StackView stack

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.stack.pop()
        }
    }
}
