import QtQuick
import Quickshell

Rectangle {
    id: clockWrapper

    implicitWidth: parent.width - 1
    implicitHeight: clockText.height

    
    Text {
        id: clockText
        anchors.centerIn: parent

        text: Qt.formatDateTime(sysClock.date, "HH\nmm")
    
        color: "#ffffff" 
    

        font {
            family: "JetBrains Mono"
            pixelSize: 16
            weight: Font.Bold
            letterSpacing: 1
        }

        SystemClock {
            id: sysClock
            precision: SystemClock.Seconds    
        }
    }
}
