import QtQuick
import Quickshell
import Quickshell.Services.UPower

Rectangle {
    id: battery

    readonly property var icons: ["󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰂄"]
    
    property int animIndex: 0

    // animate battery
    Timer {
        interval: 500 
        running: !UPower.onBattery 
        repeat: true
        onTriggered: battery.animIndex = (battery.animIndex + 1) % battery.icons.length
    }

    readonly property color batteryColor: {
        if (!UPower.onBattery) return "#14bc14" 
        let p = UPower.displayDevice.percentage
        if (p <= 0.15) return "#FF0000"
        if (p <= 0.30) return "#FF8C00"
        if (p <= 0.50) return "#FFFF00"
        if (p <= 0.80) return "#1bbf1b"
        return "#14bc14"
    }

    readonly property string batteryIcon: {
        if (!UPower.onBattery) return icons[animIndex]
        
        let p = UPower.displayDevice.percentage
        let index = Math.floor(p * 10)
        
        return icons[Math.min(Math.max(index, 0), icons.length - 1)]
    }

    implicitHeight: batteryText.height + 10
    implicitWidth: parent.width - 1

    Text {
        id: batteryText
        anchors.centerIn: parent
        text: batteryIcon
        color: battery.batteryColor
        font {
            family: "Symbols Nerd Font"
            pixelSize: 20
            weight: Font.Bold
        }        
    }
}

