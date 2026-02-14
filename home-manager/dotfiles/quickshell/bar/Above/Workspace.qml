import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Rectangle {
    property var icons: []
    property bool active: false
    property int id: 0

    implicitWidth: layout.implicitWidth + 20
    implicitHeight: 40
    radius: 5
    
    // Выделяем серым, если воркспейс активен
    color: active ? "#444444" : "transparent"
    
    border.color: "#666666"
    border.width: 1

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: icons
            Text {
                text: modelData
                color: "white"
                font.family: "Icons" // Название вашего шрифта с Nerd Fonts
                font.pixelSize: 18
            }
        }
        
        // Если окон нет, можно показать номер воркспейса
        Text {
            visible: icons.length === 0
            text: id
            color: "#888888"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`workspace ${id}`)
    }
}
