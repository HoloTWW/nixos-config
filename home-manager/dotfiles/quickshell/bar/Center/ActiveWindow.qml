import Quickshell.Hyprland
import Quickshell
import QtQuick

import "../../data" // iconmap
import "../../config"




Text {
    id: activeWindow

    readonly property var win: Hyprland.activeToplevel

    readonly property var title: IconData.getAppName(win?.title)

    text:  IconData.getIcon(title) + " " + title

    color: Config.primaryText
    anchors.centerIn:parent

    NumberAnimation on opacity {
        id: fadeAnim
        from: 0
        to: 1
        duration: 500 // Длительность в мс
        easing.type: Easing.InOutQuad
    }

    onTextChanged: fadeAnim.restart()
    

    font {
        family: "JetBrains Mono"
        pixelSize: 16
        weight: Font.Bold
        letterSpacing: 1
    }
}