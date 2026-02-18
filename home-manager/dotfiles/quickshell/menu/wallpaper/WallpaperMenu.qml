import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Qt.labs.folderlistmodel
import QtQuick
import "../../config"

PopupWindow {
    id: root
    implicitWidth: 800
    implicitHeight: 300
    color: "transparent"

    signal closeRequested() 
    
    property bool active: false



    visible: active || menuBody.y < root.height

    HyprlandFocusGrab {
        id: grab
        windows: [ root ]
        active: root.active 
    }

    Process {
        id: wallpaperSetter
        command: ["swww", "img"] // Базовая команда
        
        onExited: (exitCode) => {
            if (exitCode !== 0) console.log("Error swww:", stderr)
        }
    }


    Item {
        id: container
        anchors.fill: parent
        clip: true

        focus: true

        onVisibleChanged: {
            if (visible) {
                container.forceActiveFocus()
            }
        }

        Keys.onEscapePressed: {

            root.closeRequested();
        }
        
        Keys.onReturnPressed: {
            const model = carousel.folderModel;
            const currentPath = model.get(carousel.currentIndex, "filePath");
            console.log(currentPath)
            
            if (currentPath) {
                wallpaperSetter.running = false; 
                wallpaperSetter.command = [
                    "swww", 
                    "img", 
                    currentPath, 
                    "--transition-type", 
                    "wipe",
                    "--transition-fps",
                    60,
                    "--transition-duration",
                    1];
                console.log(wallpaperSetter.command)
                wallpaperSetter.running = true; 

                root.closeRequested();
            }
        }

        Keys.onLeftPressed: carousel.decrementCurrentIndex()
        Keys.onRightPressed: carousel.incrementCurrentIndex()

        Rectangle { 
            id: menuBody
            width: parent.width
            height: parent.height
            color: Config.primaryColor
            radius: Config.cornerRadius
            
            y: root.active ? 0 : root.height
            Behavior on y {
                NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
            }

            WallpaperCarousel {id:carousel}

        }
    }

    onActiveChanged: {
        if (active) {
            container.forceActiveFocus();
        }
    }
}
