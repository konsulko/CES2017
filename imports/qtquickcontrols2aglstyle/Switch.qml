import QtQuick 2.6
import QtQuick.Templates 2.0 as T

T.Switch {
    id: root
    implicitWidth: indicator.implicitWidth
    implicitHeight: indicator.implicitHeight

    indicator: Image {
        source: root.checked ? './images/HMI_Settings_Toggle_ON.svg' : './images/HMI_Settings_Toggle_OFF.svg'
    }
}
