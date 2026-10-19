import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "music"

import "../config"

PanelWindow {
    id: toplevel
    
    color: "#9c1818"
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: Config.verticalMargin

    WrapperMouseArea {
        id: musicTrigger
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300 // Ширина зоны активации на топбаре
        height: parent.height
        hoverEnabled: true
    }



    MusicPlayer { 
        anchor.rect.x: parentWindow.width / 2 - width / 2
        anchor.window: toplevel
        trigger: musicTrigger
    }
}
