import QtQuick
import Quickshell

Rectangle {
    id: aboveBar
    
    color: "transparent"
    height: layout.height
    
    Column {
        id:layout
        anchors.horizontalCenter: parent.horizontalCenter
        
        Workspaces {}
        
    }
}