import QtQuick
import Quickshell

PanelWindow {
    anchors {top: true; left: true; right: true}
    height: 32
    color: "#383c4a"

    Row {
        anchors.centerIn: parent
        spacing: 10

        Clock {}
    }

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter:parent.verticalCenter

        Loader { active: true; sourceComponent: Workspaces {} }
    }
}
