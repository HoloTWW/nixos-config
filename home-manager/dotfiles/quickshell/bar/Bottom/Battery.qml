import QtQuick
import Quickshell
import Quickshell.Services.UPower

Rectangle {
    id: battery

    
    readonly property color batteryColor: {
        if (!UPower.onBattery) return "#339833" 
        let p = UPower.displayDevice.percentage
        if (p <= 0.15) return "#FF0000" // Красный
        if (p <= 0.30) return "#FF8C00" // Оранжевый
        if (p <= 0.50) return "#FFFF00" // Желтый
        if (p <= 0.80) return "#1bbf1b" // Салатовый
        return "#14bc14"              // Зеленый
    }

    // Определяем иконку
    readonly property string batteryIcon: {
        if (!UPower.onBattery) return "󰂄" // Заряжается
        let p = UPower.displayDevice.percentage
        if (p <= 0.1) return "󰁺"
        if (p <= 0.2) return "󰁻"
        if (p <= 0.3) return "󰁼"
        if (p <= 0.4) return "󰁽"
        if (p <= 0.5) return "󰁾"
        if (p <= 0.6) return "󰁿"
        if (p <= 0.7) return "󰂀"
        if (p <= 0.8) return "󰂁"
        if (p <= 0.9) return "󰂂"
        return "󱈏" // 100% или выше 90
    }

    color: "#453030"
    
    implicitHeight: batteryText.height + 10 // Добавил небольшой отступ для красоты
    implicitWidth: parent.width - 1

    Text {
        id: batteryText
        anchors.centerIn: parent
        
        text: batteryIcon
        color: battery.batteryColor

        font {
            family: "Symbols Nerd Font"
            pixelSize: 18
            weight: Font.Bold
            letterSpacing: 1
        }        
    }
}
