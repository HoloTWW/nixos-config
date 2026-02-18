import QtQuick
import Quickshell
import Quickshell.Io

import "../config"
import "wallpaper"

PanelWindow {
    id: toplevel
    property bool wallpaperActive: false
    color: "transparent"
    
    anchors {
        bottom: true
        left: true
        right: true
    }
    
    implicitHeight: Config.verticalMargin
    
    IpcHandler {
        target: "menu_wallpaper"
        
        function toggleWallpaper(){
            console.log("ipc")
            toplevel.wallpaperActive = !toplevel.wallpaperActive
            console.log(toplevel.wallpaperActive)
        }
    }

    WallpaperMenu {
        active: toplevel.wallpaperActive
        onCloseRequested: {toplevel.wallpaperActive = false;}
        anchor.rect.x: parentWindow.width / 2 - width / 2
        anchor.window: toplevel
    }
}
