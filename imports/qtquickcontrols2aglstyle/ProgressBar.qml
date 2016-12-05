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
