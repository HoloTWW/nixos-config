import QtQuick

pragma Singleton 

QtObject {
    readonly property var icons: ({
        "Яндекс Музыка": "",
        "Yandex Music": "",
        "Visual Studio Code": "",
        "Code": " ",
        "Mozilla Firefox": "",
        "Firefox Web Browser": "",
        "Google Chrome": "",
        "Brave": "",
        "Chromium": "",
        "Helix": "", 
        "Foot": "",
        "Alacritty": "",
        "Kitty": "",
        "Telegram": "",
        "Discord": "",
        "Spotify": "",
        "GIMP": "",
        "Inkscape": "",
        "Obsidian": "󰠮"
    })

    function getAppName(title) {
        if (!title) return "Desktop";
        
        let parts = title.split(/ [—|-] /);
        return parts[parts.length - 1].trim();
    }

    function getIcon(name){
        return icons[name] || " "
    }
}