import Quickshell.Hyprland
import Quickshell
import QtQuick

import "../../data" // iconmap





Text {
    id: activeWindow

    readonly property var win: Hyprland.activeToplevel

    text:  getIcon(win?.title) + " " + getAppName(win?.title)
    //text: "Test Title"
    color: "#ffffff"
    anchors.centerIn:parent

    function getAppName(title) {
        if (!title) return "Desktop";
        
        let parts = title.split(/ [—|-] /);
        return parts[parts.length - 1].trim();
    }

    NumberAnimation on opacity {
        id: fadeAnim
        from: 0
        to: 1
        duration: 500 // Длительность в мс
        easing.type: Easing.InOutQuad
    }

    onTextChanged: fadeAnim.restart()

    function getIcon(title) {
        let name = getAppName(title);
        // Возвращаем иконку из словаря, либо иконку "окна" по умолчанию
        return IconData.getIcon(name); 
    }

    readonly property var names: ({
        "code": "VS Code",
        "firefox": "Firefox Browser",
        "foot": "Terminal"
    })
    

    font {
        family: "JetBrains Mono"
        pixelSize: 16
        weight: Font.Bold
        letterSpacing: 1
    }
}