import Quickshell
import QtQuick

import "bar"
import "config"
import "menu"
import "notify"

ShellRoot {
    id: root

    NotificationBar {}


    Bar { 
        id: lBar; 
        implicitWidth: Config.barWidth; 
        verticalMargin: Config.barVerticalMargin; 
        cornerRadius: 20 
    }

    BottomMenu {}

}
