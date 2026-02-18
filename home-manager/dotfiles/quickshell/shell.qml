import Quickshell
import QtQuick

import "bar"
import "config"
import "menu"

ShellRoot {
    id: root

    Bar { 
        id: lBar; 
        implicitWidth: Config.barWidth; 
        verticalMargin: Config.barVerticalMargin; 
        cornerRadius: 20 
    }

    BottomMenu {}

}
