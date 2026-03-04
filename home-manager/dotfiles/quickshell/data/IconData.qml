import QtQuick
import Quickshell
import Quickshell.Io

pragma Singleton

QtObject {
    property var appRegistry: ({})
    property var exceptions: ({})

    property FileView configFile: FileView {
        path: Qt.resolvedUrl("./apps.json")
        blockLoading: true
        onLoaded: {
            try { appRegistry = JSON.parse(this.text() || "{}"); } catch (e) {}
        }
    }

    property FileView exceptionsFile: FileView {
        path: Qt.resolvedUrl("./appex.json")
        blockLoading: true
        onLoaded: {
            try { exceptions = JSON.parse(this.text() || "{}"); } catch (e) {}
        }
    }

    function getWindowData(toplevel) {
        if (!toplevel || !toplevel.wayland) return { "title": "Desktop", "icon": "" };
        
        const appId = toplevel.wayland.appId.toLowerCase();
        const rawTitle = toplevel.title || "";

        for (let prefix in exceptions) {
            if (appId.startsWith(prefix.toLowerCase())) {
                return {
                    "title": formatTitle(rawTitle),
                    "icon": exceptions[prefix] 
                };
            }
        }

        if (appRegistry && appRegistry[appId]) {
            return {
                "title": appRegistry[appId].title,
                "icon": appRegistry[appId].icon
            };
        }

        return { "title": formatTitle(rawTitle), "icon": "" };
    }

    function formatTitle(title) {
        if (!title) return "Desktop";
        let parts = title.split(/ [—|-] /);
        let name = parts[parts.length - 1].trim();
        if (!name) return title;
        
        let finalName = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
        return finalName.length > 40 ? finalName.substring(0, 40) + "..." : finalName;
    }
}
