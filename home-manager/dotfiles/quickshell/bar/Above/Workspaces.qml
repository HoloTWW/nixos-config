import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    spacing: 10

    // Маппинг классов окон на иконки Nerd Fonts
    readonly property var iconMap: {
        "firefox": "  ",
        "kitty": "  ",
        "code": "  ",
        "thunar": "  ",
        "discord": "  ",
        "spotify": "  ",
        "default": "  "
    }

    function getIcon(clientClass) {
        let cls = clientClass.toLowerCase();
        return iconMap[cls] || iconMap["default"];
    }

    Repeater {
        // Берем список воркспейсов (сортируем по ID)
        model: Hyprland.workspaces.values.sort((a, b) => a.id - b.id)

        Workspace {
            property var wsId: modelData.id
            id: wsId
            active: Hyprland.focusedWorkspace === modelData
            
            // Фильтруем окна, которые принадлежат этому воркспейсу
            icons: {
                let list = [];
                for (let client of Hyprland.clients.values) {
                    if (client.workspace === modelData) {
                        list.push(getIcon(client.class));
                    }
                }
                return list;
            }
        }
    }
}
