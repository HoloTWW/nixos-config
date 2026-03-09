import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../data" // Убедись, что путь к IconData верный

QtObject {
    id: manager

    // Кешированные данные об иконках: { wsId: [{icon, active}, ...] }
    readonly property var iconMap: {
        let map = {};
        let clients = Hyprland.toplevels.values;
        
        for (let i = 0; i < clients.length; i++) {
            let client = clients[i];
            if (!client || !client.workspace) continue;

            let id = client.workspace.id;
            if (!map[id]) map[id] = [];

            let data = IconData.getWindowData(client);
            map[id].push({
                "icon": data ? data.icon : "",
                "active": Hyprland.activeToplevel === client
            });
        }
        return map;
    }

    // Максимальный ID для модели Repeater
    readonly property int maxWsId: {
        let max = Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1;
        let workspaces = Hyprland.workspaces.values;
        for (let i = 0; i < workspaces.length; i++) {
            if (workspaces[i].id > max) max = workspaces[i].id;
        }
        return max;
    }
}
