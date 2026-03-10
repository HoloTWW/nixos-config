import Quickshell.Hyprland
import Quickshell
import QtQuick

import "../../data" // iconmap
import "../../config"




Text {
    id: activeWindow

    readonly property bool isWindowOnCurrentWs: {
        let top = Hyprland.activeToplevel;
        let focusedWs = Hyprland.focusedWorkspace;
        return top && focusedWs && top.workspace === focusedWs;
    }

    readonly property var win: isWindowOnCurrentWs ? IconData.getWindowData(Hyprland.activeToplevel) : null

    text: win ? (win.icon + " " + win.title) : "Desktop"

    color: Config.primaryText
    anchors.centerIn:parent

    transform: Translate {
        id: textTrans
        y: 0
    }

    ParallelAnimation {
        id: fadeAnim
        
        NumberAnimation { 
            target: activeWindow; property: "opacity"
            from: 0; to: 1; duration: 300; easing.type: Easing.OutCubic 
        }
        
        NumberAnimation { 
            target: textTrans; property: "y"
            from: 10; to: 0; duration: 300; easing.type: Easing.OutBack 
        }
    }

    onTextChanged: fadeAnim.restart()
    

    font {
        family: "JetBrains Mono"
        pixelSize: 16
        weight: Font.Bold
        letterSpacing: 1
    }
}