import QtQuick
import Quickshell

import "../../config"

Rectangle {
    id: clockWrapper
    implicitWidth: parent.width - 1
    implicitHeight: clockColumn.height
    color: "transparent"

    Column {
        id: clockColumn
        anchors.centerIn: parent

        Text {
            id: hoursText
            text: Qt.formatDateTime(sysClock.date, "HH")
            color: Config.primaryText
            font { family: "JetBrains Mono"; pixelSize: 16; weight: Font.Bold; letterSpacing: 1 }
        }

        Text {
            id: minutesText
            text: Qt.formatDateTime(sysClock.date, "mm")
            color: Config.primaryText
            font { family: "JetBrains Mono"; pixelSize: 16; weight: Font.Bold; letterSpacing: 1 }

            // Анимация при изменении текста
            onTextChanged: fadeAnim.restart()

            NumberAnimation on opacity {
                id: fadeAnim
                from: 0
                to: 1
                duration: 800
                easing.type: Easing.InOutQuad
            }
        }
    }

    SystemClock {
        id: sysClock
        precision: SystemClock.Minutes // Для минут достаточно такой точности
    }
}
