import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Templates 2.0 as T

T.ApplicationWindow {
    id: root
    width: 1080
    height: 1920 - 218 - 215
    visible: true
    flags: Qt.FramelessWindowHint

    font.family: 'Robota'

    background: Image {
        anchors.fill: parent
        anchors.topMargin:  -218
        anchors.bottomMargin: -215
        source: './images/AGL_HMI_Background_NoCar-01.png'
    }
}
