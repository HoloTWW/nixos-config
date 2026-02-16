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
        "Obsidian": "󰠮",
        "empty_workspace": ""
    })

    // idk why this stuff install with only russian title 

    readonly property var ruNames: ({
        "Яндекс Музыка": "Yandex Music",
        "yandex-music": "Yandex Music",
        "firefox" : "Firefox",
        "собираем музыку для вас": "Yandex Music"
    })

    function getAppName(title) {
        if (!title) return "Desktop";
        
        let parts = title.split(/ [—|-] /);
        let line = parts[parts.length - 1].trim();

        return ruNames[line] || line;
    }

    function getIcon(name){
        return icons[name] || "󰡯"
    }
}