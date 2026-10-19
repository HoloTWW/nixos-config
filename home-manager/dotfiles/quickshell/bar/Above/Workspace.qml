import QtQuick
import Quickshell.Hyprland
import "../../config"

Item {
    id: workspaceRoot
    property var icons: []
    property bool active: false
    property int wsId: 0  

    width: parent ? parent.width : 40
    implicitHeight: (icons.length > 0 ? (icons.length * 22) : 22) + 5
    
    Behavior on implicitHeight { NumberAnimation { duration: 200 } }

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Config.unfocusedColor
        opacity: active ? 0 : 1
    }

    Column {
        anchors.centerIn: parent
        spacing: 2

        Text {
            visible: workspaceRoot.icons.length === 0
            text: " "
            color: Config.primaryText
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            model: workspaceRoot.icons
            delegate: Text {
                text: modelData.icon
                color: modelData.active ? Config.activeText : Config.primaryText 
                font.family: "Symbols Nerd Font" 
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: if (wsId > 0) Hyprland.dispatch(`workspace ${wsId}`)
    }
}
