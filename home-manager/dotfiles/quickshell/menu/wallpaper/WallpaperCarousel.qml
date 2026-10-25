import QtQuick
import Quickshell
import Quickshell.Widgets
import Qt.labs.folderlistmodel

import "../../config"

Item {
    id: carousel
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0
    clip: true

    property bool isCarouselMode: true
    property alias folderModel: internalFolderModel

    property int currentIndex: isCarouselMode ? carouselView.currentIndex - carouselLoopStart : cardsView.currentIndex
    property int logicalIndex: 0
    property int carouselLoopStart: 0
    property int carouselLoopCount: 3

    Component.onCompleted: {
        rebuildCarouselLoop();
    }

    function rebuildCarouselLoop() {
        wallpaperLoopModel.clear();
        const count = internalFolderModel.count;
        if (count <= 0) return;

        for (let repeat = 0; repeat < carouselLoopCount; ++repeat) {
            for (let i = 0; i < count; ++i) {
                const filePath = internalFolderModel.get(i, "filePath") || "";
                const fileUrl = internalFolderModel.get(i, "fileUrl") || "";
                wallpaperLoopModel.append({ filePath: filePath, fileUrl: fileUrl });
            }
        }

        carouselLoopStart = count;
        carouselView.model = wallpaperLoopModel;
        logicalIndex = 0;
        carouselView.currentIndex = carouselLoopStart;
    }

    function incrementCurrentIndex() {
        if (isCarouselMode) {
            const count = internalFolderModel.count;
            if (count <= 1) return;

            logicalIndex = (logicalIndex + 1) % count;
            carouselView.currentIndex = carouselLoopStart + logicalIndex;
            carouselView.positionViewAtIndex(carouselView.currentIndex, ListView.Center);
        } else {
            cardsView.incrementCurrentIndex();
        }
    }

    function decrementCurrentIndex() {
        if (isCarouselMode) {
            const count = internalFolderModel.count;
            if (count <= 1) return;

            logicalIndex = (logicalIndex - 1 + count) % count;
            carouselView.currentIndex = carouselLoopStart + logicalIndex;
            carouselView.positionViewAtIndex(carouselView.currentIndex, ListView.Center);
        } else {
            cardsView.decrementCurrentIndex();
        }
    }

    ListModel {
        id: wallpaperLoopModel
    }

    FolderListModel {
        id: internalFolderModel
        folder: "file://" + Quickshell.env("HOME") + "/wallpapers"
        nameFilters: ["*.jpg", "*.png", "*.webp", "*.jpeg"]
        showDirs: false
        onCountChanged: rebuildCarouselLoop()
    }

    ListView {
        id: carouselView
        anchors.fill: parent
        anchors.margins: 20
        visible: isCarouselMode
        enabled: isCarouselMode
        orientation: ListView.Horizontal
        spacing: 28
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.StopAtBounds
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 150
        highlightMoveVelocity: 1500
        preferredHighlightBegin: width * 0.5 - 120
        preferredHighlightEnd: width * 0.5 + 120
        highlightRangeMode: ListView.StrictlyEnforceRange
        model: wallpaperLoopModel

        delegate: Item {
            id: carouselItem
            required property int index
            required property string filePath
            required property string fileUrl

            property string wallpaperSource: {
                if (filePath && filePath.length > 0) return filePath.indexOf("file://") === 0 ? filePath : "file://" + filePath;
                if (fileUrl && fileUrl.length > 0) return fileUrl;
                return "";
            }

            width: 210
            height: carouselView.height * 0.88
            scale: ListView.isCurrentItem ? 1.08 : 0.9
            opacity: ListView.isCurrentItem ? 1 : 0.65
            z: ListView.isCurrentItem ? 10 : 1

            Behavior on scale { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on opacity { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }

            Rectangle {
                anchors.fill: parent
                radius: 14
                color: Qt.rgba(1, 1, 1, 0.08)

                Image {
                    anchors.fill: parent
                    source: wallpaperSource
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    sourceSize.width: 600
                    sourceSize.height: 600
                }
            }
        }
    }

    ListView {
        id: cardsView
        anchors.fill: parent
        anchors.margins: 20
        visible: !isCarouselMode
        enabled: !isCarouselMode
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        boundsBehavior: Flickable.StopAtBounds
        highlightFollowsCurrentItem: true
        preferredHighlightBegin: width * 0.5 - 120
        preferredHighlightEnd: width * 0.5 + 120
        highlightRangeMode: ListView.StrictlyEnforceRange
        model: internalFolderModel

        delegate: Item {
            id: stackItem
            required property int index
            required property string filePath
            required property string fileUrl

            property string wallpaperSource: {
                if (filePath && filePath.length > 0) return filePath.indexOf("file://") === 0 ? filePath : "file://" + filePath;
                if (fileUrl && fileUrl.length > 0) return fileUrl;
                return "";
            }
            property int relativeIndex: index - ListView.view.currentIndex
            property int stackOffset: Math.min(Math.abs(relativeIndex), 6)

            width: 220
            height: ListView.view.height * 0.9
            x: relativeIndex * 52
            y: stackOffset * 20
            scale: relativeIndex === 0 ? 1 : 1 - stackOffset * 0.15
            rotation: relativeIndex * 8
            opacity: relativeIndex === 0 ? 1 : 1 - stackOffset * 0.18
            z: 100 - Math.abs(relativeIndex)

            Behavior on x { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on y { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
            Behavior on rotation { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

            Rectangle {
                anchors.fill: parent
                radius: 14
                color: relativeIndex === 0 ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(1, 1, 1, 0.08)

                Image {
                    anchors.fill: parent
                    source: wallpaperSource
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    sourceSize.width: 600
                    sourceSize.height: 600
                }
            }
        }
    }
}
