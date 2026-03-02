import QtQuick

pragma Singleton 

QtObject {
    readonly property var icons: ({
        "Яндекс Музыка": "󰎆",
        "Yandex Music": "󰎆",
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
        "Steam":"",
        "GIMP": "",
        "Inkscape": "",
        "Obsidian": "󰠮",
        "Volume Control": "󰙪",
        "empty_workspace": ""
    })

    // idk why this stuff install with only russian title 

    readonly property var ruNames: ({
        "Яндекс Музыка": "Yandex Music",
        "yandex-music": "Yandex Music",
        "собираем музыку для вас": "Yandex Music"
    })

    function getAppName(title) {
        if (!title) return "Desktop";

        // check if title in icons
        for (let key in icons) {
            if (title.toLowerCase().includes(key.toLowerCase())) {
                return key; 
            }
        }

        // else make cut and capitalize 
        let parts = title.split(/ [—|-] /);
        let line = parts[parts.length - 1].trim();
        let result = ruNames[line] || line;

        return result
            .split(' ')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
            .join(' ');
    }


    function getIcon(name){
        let icon = icons[name]  || "󰡯";
        if (name == "Desktop") {
            icon = "";
        }
        return icon
    }
}