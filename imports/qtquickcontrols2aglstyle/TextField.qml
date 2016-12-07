import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Templates 2.0 as T

T.TextField {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    font.family: 'Roboto'
    font.pixelSize: Math.min(Screen.width, Screen.height) / 30
    color: 'white'

    background: Item {
        implicitWidth: 586
        implicitHeight: Math.min(Screen.width, Screen.height) / 28
        Rectangle {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            height: 1
            color: 'white'
        }
    }
}
