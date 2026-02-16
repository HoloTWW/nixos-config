import Quickshell
import QtQuick

import "bar"
import "config"

ShellRoot {
    id: root

    Bar { 
        id: lBar; 
        implicitWidth: Config.barWidth; 
        verticalMargin: Config.barVerticalMargin; 
        cornerRadius: 20 
    }

}
