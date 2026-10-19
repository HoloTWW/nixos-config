import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../config" 

Item {
    id: root

    WorkspaceManager { id: wsData }

    property int leftPadding: 0
    property int rightPadding: 0

    readonly property int maxVisible: Config.barVisibleWorkspaces
    readonly property int spacing: 6
    
    // Вместо JS-функции считаем высоту на лету через contentHeight Column
    implicitWidth: 40
    implicitHeight: internalLayout.childrenRect.height 

    Behavior on implicitHeight { 
        NumberAnimation { duration: 250; easing.type: Easing.OutCubic } 
    }

    clip: true

    Item {
        id: viewContainer
        anchors.fill: parent
        anchors.leftMargin: root.leftPadding
        anchors.rightMargin: root.rightPadding

        // Фокус-индикатор теперь следит за активным ID, а не ищет по детям
        Rectangle {
            id: focusIndicator
            z: 0; width: parent.width; radius: 5
            color: Config.focusedColor
            visible: Hyprland.focusedWorkspace !== null
            
            // Находим нужный элемент в Repeater напрямую по индексу
            readonly property Item target: repeater.itemAt(Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id - 1 : -1)

            y: target ? target.y + internalLayout.y : 0
            height: target ? target.height : 0

            Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
            Behavior on height { NumberAnimation { duration: 200 } }
        }

        Column {
            id: internalLayout
            z: 1; spacing: root.spacing; width: parent.width

            // Автоматический скролл
            readonly property int activeIdx: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id - 1 : 0
            
            y: {
                if (activeIdx < maxVisible) return 0;
                let targetItem = repeater.itemAt(activeIdx - (maxVisible - 1));
                // Используем прямое значение y, которое меняется вместе с анимацией высоты соседей сверху
                return targetItem ? -targetItem.y : 0;
            }

            //Behavior on y { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

            Repeater {
                id: repeater
                model: wsData.maxWsId
                
                Workspace {
                    readonly property int currentId: index + 1
                    wsId: currentId
                    active: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === currentId
                    icons: wsData.iconMap[currentId] || []
                }
            }
        }
    }
}
