import QtQuick

pragma Singleton 
QtObject {
    readonly property var primaryColor: "#3a6955"
    readonly property var unfocusedColor: "#2e5444"
    readonly property var focusedColor: "#4a856d"

    readonly property var primaryText: "#ffffff"
    readonly property var activeText: "#80ffcf"
    
    readonly property var barVerticalMargin: 15
    readonly property var barWidth: 40
    readonly property var frameSize: 10

    readonly property var cornerRadius: 10

    readonly property var verticalMargin: 2 
}