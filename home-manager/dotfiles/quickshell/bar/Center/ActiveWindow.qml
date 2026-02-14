import Quickshell.Hyprland
import Quickshell
import QtQuick





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

    function getIcon(title) {
        let name = getAppName(title);
        // Возвращаем иконку из словаря, либо иконку "окна" по умолчанию
        return iconMap[name] || "  "; 
    }

    readonly property var names: ({
        "code": "VS Code",
        "firefox": "Firefox Browser",
        "foot": "Terminal"
    })

    readonly property var iconMap: ({
        "Visual Studio Code": " ",
        "Code": " ",
        "Mozilla Firefox": "",
        "Firefox Web Browser": "",
        "Google Chrome": "",
        "Brave": "",
        "Chromium": "",
        "Helix": "  ", 
        "Foot": "",
        "Alacritty": "",
        "Kitty": "",
        "Telegram": "",
        "Discord": "  ",
        "Spotify": "",
        "GIMP": "",
        "Inkscape": "",
        "Obsidian": "  "
    })
    

    font {
        family: "JetBrains Mono"
        pixelSize: 16
        weight: Font.Bold
        letterSpacing: 1
    }
}