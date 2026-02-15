import Quickshell
import QtQuick
import "Above"
import "Center"
import "Bottom" 

import "../config" 

PanelWindow {
    id: bar
    // Defines position: left side, full height
    anchors {
        left: true
        top: true
        bottom: true
    }
    
    implicitWidth: 40// Set desired width
    color: Config.primaryColor

    
    Rectangle{
        anchors.fill: parent
        color: bar.color

        Rectangle {
            implicitWidth: bar.width
        }
        
        Above {
            implicitWidth:bar.width
            anchors.top: parent.top 
            anchors.topMargin: 15
            
        }

        Center {
            implicitWidth:bar.width
        }
        
        Bottom {
            implicitWidth:bar.width
        
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
        }
    }

    // Add components here (e.g., Workspace, Clock, Taskbar)
}
