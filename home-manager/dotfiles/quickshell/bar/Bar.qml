import Quickshell
import QtQuick
import "Above"
import "Center"
import "Bottom" 
import "../config" 

PanelWindow {
    id: bar
    
    property int verticalMargin: 20
    property int cornerRadius: Config.cornerRadius
    property color backgroundColor: Config.primaryColor

    anchors {
        left: true
        top: true
        bottom: true
    }
    
    implicitWidth: 40
    color: "transparent" 

    Rectangle {
        id: background
        color: bar.backgroundColor
        radius: bar.cornerRadius
        
        anchors {
            fill: parent
            topMargin: bar.verticalMargin
            bottomMargin: bar.verticalMargin
        }
        
        Rectangle {
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: parent.radius
            color: parent.color
            visible: parent.radius > 0
        }

        Above {
            width: parent.width
            anchors.top: parent.top 
            anchors.topMargin: 15
        }

        Center {
            width: parent.width
            anchors.centerIn: parent
        }
        
        Bottom {
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
        }
    }
}
