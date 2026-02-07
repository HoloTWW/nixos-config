import QtQuick
import Quickshell

Rectangle {
    id: clockWrapper

    color: "#3a6955"
    radius: 6

    width: clockText.width + 20
    height: clockText.height + 8

    SystemClock {
        id: sysClock
        precision: SystemClock.Seconds    
    }

    
    Text {
        id: clockText
        anchors.centerIn: parent

        
        text: Qt.formatDateTime(sysClock.date, "ddd; dd MMM, HH:mm")
    
        color: "#ffffff"
    

        font {
            family: "JetBrains Mono"
            pixelSize: 16
            weight: Font.Bold
            letterSpacing: 1
        }
    }
}
