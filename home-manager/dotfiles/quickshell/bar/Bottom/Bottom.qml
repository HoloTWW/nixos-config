import QtQuick
import Quickshell

Rectangle {
    id: bottomBar
    
    color: "transparent"
    height: layout.height
    
    Column {
        id:layout
        anchors.horizontalCenter: parent.horizontalCenter
        
        Clock {}
        Battery {}
    }
}