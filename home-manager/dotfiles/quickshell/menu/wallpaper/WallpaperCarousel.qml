import QtQuick
import Quickshell
import Quickshell.Widgets
import Qt.labs.folderlistmodel // Добавьте этот импорт

import "../../config"

// Внутри menuBody заменяем старый PathView на этот:
PathView {
    id: carousel
    property alias folderModel: internalFolderModel
    
    anchors.fill: parent
    anchors.margins: 20
    
    // Настройки фокуса и центра (как делали раньше)
    pathItemCount: 5
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    highlightRangeMode: PathView.StrictlyEnforceRange

    // МОДЕЛЬ: Читает файлы из ~/wallpapers
    model: FolderListModel {
        id: internalFolderModel
        folder: "file://" + Quickshell.env("HOME") + "/wallpapers"
        nameFilters: ["*.jpg", "*.png", "*.webp", "*.jpeg"]
        showDirs: false
    }

    path: Path {
        startX: -150; startY: carousel.height / 2
        PathLine { x: carousel.width + 150; y: carousel.height / 2 }
    }

    delegate: Item {
        id: wrapper

        width: 200 
        height: parent.height * 0.90
        
        scale: PathView.isCurrentItem ? 1.2 : 0.8
        opacity: PathView.isCurrentItem ? 1.0 : 0.5
        z: PathView.isCurrentItem ? 10 : 1
        Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }

        ClippingWrapperRectangle {
            anchors.fill: parent
            radius: 10 // Скругление углов


            Image {
                id: img
                anchors.fill: parent
                
                fillMode: Image.PreserveAspectCrop
                
                source: fileUrl
                asynchronous: true
                
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
            }   
        }
    }
}
