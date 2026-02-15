import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "../../data" // iconmap

ColumnLayout {
    spacing: 5

    Repeater {
        model: [...Hyprland.workspaces.values].sort((a, b) => a.id - b.id)

        Workspace {
            id: ws
            wsId: modelData.id 
            active: Hyprland.focusedWorkspace === modelData
            
            // Передаем массив иконок напрямую в алиас модели репитера
            icons: {
                let list = [];
                for (let client of Hyprland.toplevels.values) {
                    if (client.workspace === modelData) {
                        let title = IconData.getAppName(client.title);
                        list.push({
                            "icon": IconData.getIcon(title),
                            // Проверка: является ли это окно активным в данный момент
                            "active": Hyprland.activeToplevel === client
                        });
                    }
                }
                return list;
            }
        }
    }
}
