import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "../../config"

Rectangle {
    property alias icons: iconRepeater.model 
    property bool active: false
    property int wsId: 0  

    implicitWidth: 40
    
    implicitHeight: layout.implicitHeight + 5
    radius: 5
    
    color: active ? Config.focusedColor : Config.unfocusedColor 
    border.color: "transparent"
    border.width: 1

    ColumnLayout {
        id: layout
        anchors.top: parent.top
        anchors.topMargin: 2 
        anchors.left: parent.left
        anchors.right: parent.right
        
        
        spacing: 5

        Repeater {
            id: iconRepeater
            
            Text {
                
                text: modelData
                color: "#ffffff" 
                font.family: "Symbols Nerd Font" 
                font.pixelSize: 18
                
                Layout.alignment: Qt.AlignHCenter
                 
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`workspace ${wsId}`)
    }
}
