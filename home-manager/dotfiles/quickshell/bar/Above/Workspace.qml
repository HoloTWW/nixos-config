import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../config"

Item {
    id: workspaceRoot
    property alias icons: iconRepeater.model 
    property bool active: false
    property int wsId: 0  

    implicitWidth: 40
    implicitHeight: layout.childrenRect.height + 10
    
    Behavior on implicitHeight { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

    // 1. substrate for unfocusedColor
    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Config.unfocusedColor
        opacity: active ? 0 : 1
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    // 2. content (icons)
    Column {
        id: layout
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        y: 5
        spacing: 5

        enabled: false 

        Repeater {
            id: iconRepeater
            delegate: Text {
                width: parent.width
                text: modelData.icon
                color: modelData.active ? Config.activeText : Config.primaryText 
                font.family: "Symbols Nerd Font" 
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                Behavior on color { ColorAnimation { duration: 200 } }
            }
        }
    }

    // 3. click zone
    MouseArea {
        anchors.fill: parent
        
        cursorShape: Qt.PointingHandCursor
        
        // switch Hyprland logic
        onClicked: {
            if (wsId > 0) {
                Hyprland.dispatch(`workspace ${wsId}`)
            }
        }
    }
}
