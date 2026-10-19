import QtQuick
import Quickshell
import Quickshell.Services.Notifications

PanelWindow {
    id: notificationAnchor
    
    implicitWidth: 350
    implicitHeight: notificationStack.implicitHeight + 30
    
    anchors.right: true
    anchors.top: true
    anchors.bottom: false
    
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
        
        width: parent.width - 40

        Repeater {
            model: server.trackedNotifications
            delegate: NotificationItem {
                notification: modelData
            }
        }
    }
}
