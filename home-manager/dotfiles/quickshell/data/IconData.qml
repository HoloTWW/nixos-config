import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton

QtObject {
    property var appRegistry: ({})

    property FileView configFile: FileView {
        path: Qt.resolvedUrl("./apps.json")
        blockLoading: true
        
        onLoaded: {
            let rawText = this.text();
            if (rawText && rawText.trim() !== "") {
                try {
                    appRegistry = JSON.parse(rawText);
                    console.log("IconData: App registry successfully uploaded. Keys.Count: " + Object.keys(appRegistry).length);
                } catch (e) {
                    console.log("IconData: Ошибка JSON: " + e.message);
                    appRegistry = fallbackRegistry;
                }
            } else {
                appRegistry = fallbackRegistry;
            }
        }
    }

    // big boss
    function getWindowData(toplevel) {
        if (!toplevel || !toplevel.wayland) return { "name": "Desktop", "icon": "" };
        
        const appId = toplevel.wayland.appId.toLowerCase();
        
        // Проверяем наличие в реестре
        if (appRegistry && appRegistry[appId]) {
            return {
                "name": appRegistry[appId].title,
                "icon": appRegistry[appId].icon
            };
        }

        return { "name": formatTitle(toplevel.title), "icon": "  " };
    }

    function addApp(appId, title, icon) {
        let cache = appRegistry;
        cache[appId] = { "title": title, "icon": icon };
        appRegistry = cache; // Обновляем для реактивности
        
        configFile.setText(JSON.stringify(appRegistry, null, 4));
    }

    function formatTitle(title) {
        if (!title) return "Desktop";
        let parts = title.split(/ [—|-] /);
        let name = parts[parts.length - 1].trim();
        let finalName = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
        return finalName.length > 20 ? finalName.substring(0, 20) + "..." : finalName;
    }

    readonly property var fallbackRegistry: ({
        "yandex-music-desktop": { "title": "Yandex Music", "icon": "  " },
        "code-url-handler": { "title": "VS Code", "icon": "" },
        "empty_workspace": { "title": "", "icon": "" }
    })
}
