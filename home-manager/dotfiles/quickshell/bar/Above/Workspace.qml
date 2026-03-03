import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../config"

Rectangle {
    id: workspaceRoot
    property alias icons: iconRepeater.model 
    property bool active: false
    property int wsId: 0  

    implicitWidth: 40
    
    // Вычисляем высоту на основе содержимого + отступы
    // Использование Behavior делает растяжение/сжатие плавным
    implicitHeight: layout.childrenRect.height + 10
    
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    radius: 5
    color: active ? Config.focusedColor : Config.unfocusedColor 
    border.color: "transparent"
    border.width: 1

    Column {
        id: layout
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        y: 5 // Верхний отступ
        spacing: 5

        Repeater {
            id: iconRepeater
            
            delegate: Text {
                width: parent.width
                text: modelData.icon
                color: modelData.active ? Config.activeText : Config.primaryText 
                font.family: "Symbols Nerd Font" 
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                
                // Плавная смена цвета иконки при фокусе
                Behavior on color { ColorAnimation { duration: 200 } }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch(`workspace ${wsId}`)
    }
}
