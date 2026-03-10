import QtQuick
import QtQuick.Layouts

Text {
    id: icon
    //signal clicked()
    
    // Свойства по умолчанию
    font.pixelSize: 20
    color: "white"
    
    // Центрирование внутри текстового блока
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    
    // Задаем ширину, чтобы кнопки имели одинаковую область клика

    MouseArea {
        anchors.fill: parent
        onClicked: icon.clicked()
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        
        // Эффект при наведении (опционально)
        onEntered: {
            icon.opacity = 0.7
        }
        onExited: {
            icon.opacity = 1.0
        }
    }
}