import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../../config"

PopupWindow {
    id: root
    
    property bool prev: false
    property bool next: false
    property bool togglePlay: false

    property var trigger: null

    property bool active: (trigger && trigger.containsMouse) || panelMouse.containsMouse
    onActiveChanged: {
        console.log(active)
    }

    property bool shown: false 
    
    // Состояние наведения
    property bool isHovered: (trigger && trigger.containsMouse) || panelMouse.containsMouse

    onIsHoveredChanged: {
        if (isHovered) {
            closeTimer.stop();
            shown = true;
        } else {
            closeTimer.start();
        }
        console.log("HOVERING");
    }

    Timer {
        id: closeTimer
        interval: 100 
        onTriggered: root.shown = false
    }

    

    
    implicitWidth: 500
    implicitHeight: 80 
    color: "transparent"
    visible: shown || menuBody.y > -height

    // Доступ к первому плееру
    readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null

    Item {
        anchors.fill: parent
        clip: true 

        ClippingRectangle {
            id: menuBody
            width: parent.width
            height: parent.height
            color: Config.primaryColor
            radius: 10
            topRightRadius: 0
            topLeftRadius: 0
            
            // Анимация скольжения: если не активна, уходит за верхний край
            y: root.active ? 0 : -parent.height

            Behavior on y {
                NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
            }

            MouseArea {
                id: panelMouse
                anchors.fill: parent
                hoverEnabled: true
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 15

                // Обложка
                ClippingRectangle {
                    width: 50; height: 50; radius: 5; clip: true; color: "#313244"
                    Image {
                        anchors.fill: parent
                        source: root.player ? root.player.trackArtUrl : ""
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                // Текст
                ColumnLayout {
                    Layout.fillWidth: true
                    Text {
                        text: root.player ? root.player.trackTitle : "Яндекс Музыка"
                        color: "white"; font.bold: true; elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Text {
                        text: root.player ? root.player.trackArtist : "Тишина"
                        color: "#bac2de"; font.pixelSize: 12; elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }
                Row {
                    spacing: 15

                    // Кнопка Назад
                    Text { 
                        id: btnPrev
                        text: "󰒮"
                        // Меняем цвет: если мышь внутри MouseArea — серый, иначе — белый
                        color: maPrev.containsMouse ? Config.activeText : Config.primaryText
                        font.pixelSize: 28
                        
                        MouseArea { 
                            id: maPrev
                            anchors.fill: parent
                            onClicked: root.player?.previous()
                            cursorShape: Qt.PointingHandCursor
                        }
                    }

                    // Кнопка Плей/Пауза
                    Text { 
                        id: btnToggle
                        text: (root.player && root.player.playbackState === MprisPlaybackState.Playing) ? "" : ""
                        color: togglePlay ? Config.activeText : Config.primaryText
                        font.pixelSize: 30
                        width: 28 
                        
                        MouseArea { 
                            id: maToggle
                            anchors.fill: parent
                            
                            onClicked: root.player?.togglePlaying()
                            cursorShape: Qt.PointingHandCursor 
                        }
                    }

                    // Кнопка Вперед
                    Text { 
                        id: btnNext
                        text: "󰒭"
                        color: maNext.containsMouse ? Config.activeText : Config.primaryText
                        font.pixelSize: 28
                        width: 28
                        
                        MouseArea { 
                            id: maNext
                            anchors.fill: parent
                            onClicked: root.player?.next()
                            cursorShape: Qt.PointingHandCursor 
                        }
                    }
                }
            }
        }
    }
}
