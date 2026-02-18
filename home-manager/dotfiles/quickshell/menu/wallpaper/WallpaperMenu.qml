import Quickshell
import Quickshell.Hyprland // Импортируем модуль для работы с фокусом Hyprland
import QtQuick
import "../../config"

PopupWindow {
    id: root
    implicitWidth: 800
    implicitHeight: 300
    color: "transparent"
    
    property bool active: false

    visible: active || menuBody.y < root.height

    HyprlandFocusGrab {
        id: grab
        windows: [ root ]
        active: root.active 
    }


    Item {
        id: container
        anchors.fill: parent
        clip: true

        focus: true

        onVisibleChanged: {
            if (visible) {
                container.forceActiveFocus()
                console.log("visible changed")
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

            PathView {
                id: carousel
                anchors.fill: parent
                anchors.margins: 20
                
                model: 7 
                
                pathItemCount: 5 
                preferredHighlightBegin: 0.5 
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange

                path: Path {
                    // Линия идет слева направо через весь контейнер
                    startX: -100; startY: carousel.height / 2
                    PathLine { x: carousel.width + 100; y: carousel.height / 2 }
                }

                delegate: Rectangle {
                    id: wrapper
                    width: 250
                    height: 180
                    radius: Config.cornerRadius
                    color: index % 2 === 0 ? "#313244" : "#45475a"
                    
                    scale: PathView.isCurrentItem ? 1.0 : 0.7
                    opacity: PathView.isCurrentItem ? 1.0 : 0.4
                    z: PathView.isCurrentItem ? 10 : 1

                    Behavior on scale { 
                        NumberAnimation { 
                            duration: 250; 
                            easing.type: Easing.OutCubic 
                        } 
                    }
                    Behavior on opacity { 
                        NumberAnimation { 
                            duration: 250 
                        }
                    }

                    border.color: PathView.isCurrentItem ? "white" : "transparent"
                    border.width: 3

                    Text {
                        anchors.centerIn: parent
                        text: "Wallpaper " + (index + 1)
                        color: "white"
                        font.pixelSize: 18
                        font.bold: PathView.isCurrentItem
                    }
                }
            }

        }
    }

    onActiveChanged: {
        if (active) {
            container.forceActiveFocus();
        }
    }
}
