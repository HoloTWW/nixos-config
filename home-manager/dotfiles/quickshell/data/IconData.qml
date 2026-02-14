import QtQuick

pragma Singleton 

QtObject {
    readonly property var icons: ({
        "Яндекс Музыка": " ",
        "Yandex Music": " ",
        "Visual Studio Code": " ",
        "Code": " ",
        "Mozilla Firefox": "",
        "Firefox Web Browser": "",
        "Google Chrome": "",
        "Brave": " ",
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

    function getIcon(name){
        return icons[name] || " "
    }
}