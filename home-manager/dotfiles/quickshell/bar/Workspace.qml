import QtQuick
import Quickshell

Rectangle {
    id: wsRoot
    
    // ВАЖНО: Добавьте эти две строки, чтобы принимать данные из Workspaces.qml
    property var workspaceData
    property bool active: false

    width: iconsRow.width + 16
    height: 26
    radius: 4
    
    // Теперь 'active' можно использовать для смены цвета
    color: active ? "#a6e3a1" : "transparent" 

    Row {
        id: iconsRow
        anchors.centerIn: parent
        spacing: 4

        // Если окон нет — показываем индекс
        Text {
            visible: workspaceData.windows.length === 0
            text: workspaceData.idx
            color: active ? "#11111b" : "#6c7086"
        }

        // Если окна есть — показываем иконки
        Repeater {
            model: workspaceData.windows
            Text {
                text: getIcon(modelData.app_id)
                font.family: "JetBrainsMono Nerd Font"
                color: active ? "#11111b" : "#cdd6f4"
            }
        }
    }

    function getIcon(appId) {
        if (!appId) return ""
        let id = appId.toLowerCase()
        if (id.includes("foot") || id.includes("term")) return ""
        if (id.includes("firefox")) return "  "
        return ""
    }
}
