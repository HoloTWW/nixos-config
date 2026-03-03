import QtQuick
import Quickshell
import Quickshell.Services.Notifications

PanelWindow {
    id: notificationAnchor
    
    // Ширина фиксированная, а высота зависит от контента
    width: 350
    height: notificationStack.implicitHeight + 10 // + отступы
    
    anchors.right: true
    anchors.top: true
    anchors.bottom: false // ВАЖНО: не растягиваемся вниз
    
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    
    NotificationServer {
        id: server
        onNotification: (n) => n.tracked = true
    }

    Column {
        id: notificationStack
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        spacing: 10
        
        // Эта магия заставляет Column считать свою реальную высоту
        // на основе всех видимых детей (Repeater)
        width: parent.width - 40

        Repeater {
            model: server.trackedNotifications
            delegate: NotificationItem {
                notification: modelData
            }
        }
    }
}
