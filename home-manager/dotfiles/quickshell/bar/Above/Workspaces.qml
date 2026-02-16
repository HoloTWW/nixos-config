import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "../../data" // iconmap

ColumnLayout {
    spacing: 6

    Repeater {
        model: [...Hyprland.workspaces.values].sort((a, b) => a.id - b.id)

        Workspace {
            id: ws
            wsId: modelData.id 
            active: Hyprland.focusedWorkspace === modelData
            
            icons: {
                let list = [];
                
                for (let client of Hyprland.toplevels.values) {
                    if (client.workspace === modelData) {
                        let title = IconData.getAppName(client.title);
                        list.push({
                            "icon": IconData.getIcon(title),
                            "active": Hyprland.activeToplevel === client
                        });
                    }
                }

                if (list.length <= 0){
                    list.push({
                            "icon": IconData.getIcon("empty_workspace"),
                            "active": true
                        });
                }
                return list;
            }
        }
    }
}
