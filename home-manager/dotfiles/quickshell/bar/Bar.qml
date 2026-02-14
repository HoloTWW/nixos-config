import Quickshell
import QtQuick
import "Above"
import "Center"
import "Bottom"


PanelWindow {
    id: bar
    // Defines position: left side, full height
    anchors {
        left: true
        top: true
        bottom: true
    }
    
    implicitWidth: 40// Set desired width
    color: "#3a6955" // Set bar color

    
    Rectangle{
        anchors.fill: parent
        color: bar.color
        

        Above {
            
            anchors.bottomMargin: 15
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
