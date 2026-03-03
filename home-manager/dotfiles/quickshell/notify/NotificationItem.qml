import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications

Rectangle {
    id: root
    property var notification: null
    
    implicitWidth: 310
    implicitHeight: layout.implicitHeight + 24
    color: "#1e222a"
    radius: 12
    border.color: "#3e4452"
    border.width: 1
    
    x: 400
    opacity: 0

    Component.onCompleted: showAnim.start()

    ParallelAnimation {
        id: showAnim
        NumberAnimation { target: root; property: "x"; to: 0; duration: 400; easing.type: Easing.OutCubic }
        NumberAnimation { target: root; property: "opacity"; to: 1; duration: 300 }
    }

    function dismiss() {
        hideAnim.start()
    }

    ParallelAnimation {
        id: hideAnim
        NumberAnimation { target: root; property: "x"; to: 400; duration: 300; easing.type: Easing.InCubic }
        NumberAnimation { target: root; property: "opacity"; to: 0; duration: 200 }
        onFinished: if (root.notification) root.notification.dismiss()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.dismiss()
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 12
        spacing: 4

        Text {
            text: root.notification?.summary ?? ""
            color: "white"; font.bold: true; font.pixelSize: 14
            Layout.fillWidth: true; elide: Text.ElideRight
        }

        Text {
            text: root.notification?.body ?? ""
            color: "#abb2bf"; font.pixelSize: 12
            wrapMode: Text.WordWrap; Layout.fillWidth: true; maximumLineCount: 4
        }
    }

    Timer {
        interval: 5000; running: true
        onTriggered: root.dismiss()
    }
}
