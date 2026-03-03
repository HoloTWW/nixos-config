import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../data"

Item {
    id: root
    readonly property int maxVisible: 5
    readonly property int spacing: 6

    implicitWidth: 40
    
    function getWorkspaceItems() {
        let items = [];
        for (let i = 0; i < internalLayout.children.length; i++) {
            let child = internalLayout.children[i];
            if (child && child.wsId !== undefined) {
                items.push(child);
            }
        }
        return items;
    }

    implicitHeight: {
        let items = getWorkspaceItems();
        if (items.length === 0) return 0;

        let h = 0;
        let count = Math.min(items.length, maxVisible);
        for (let i = 0; i < count; i++) {
            h += items[i].height + root.spacing;
        }
        return h > 0 ? h - root.spacing : 0;
    }
    
    // Плавное изменение высоты всей панели
    Behavior on implicitHeight {
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
    }
    
    clip: true

    ColumnLayout {
        id: internalLayout
        spacing: root.spacing
        width: parent.width

        y: {
            let items = root.getWorkspaceItems();
            let focused = Hyprland.focusedWorkspace;
            let activeIdx = items.findIndex(item => focused && item.wsId === focused.id);
            if (activeIdx < maxVisible || activeIdx === -1) return 0;

            let offsetIdx = activeIdx - (maxVisible - 1);
            let scrollY = 0;
            for (let i = 0; i < offsetIdx; i++) {
                scrollY += items[i].height + internalLayout.spacing;
            }
            return -scrollY;
        }

        Behavior on y {
            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
        }

        Repeater {
            model: {
                let all = [...Hyprland.workspaces.values];
                let focused = Hyprland.focusedWorkspace;
                let maxId = focused ? focused.id : 1;
                for (let ws of all) if (ws.id > maxId) maxId = ws.id;

                let range = [];
                for (let i = 1; i <= maxId; i++) {
                    let existing = all.find(w => w.id === i);
                    range.push(existing ? existing : { id: i });
                }
                return range;
            }

            Workspace {
                wsId: modelData.id 
                active: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === modelData.id
                
                icons: {
                    let list = [];
                    for (let client of Hyprland.toplevels.values) {
                        if (client.workspace && client.workspace.id === modelData.id) {
                            let title = IconData.getAppName(client.title);
                            list.push({
                                "icon": IconData.getIcon(title),
                                "active": Hyprland.activeToplevel === client
                            });
                        }
                    }
                    if (list.length <= 0) {
                        list.push({ "icon": " ", "active": false });
                    }
                    return list;
                }
            }
        }
    }
}
