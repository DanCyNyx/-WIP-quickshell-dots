// Source - https://stackoverflow.com/questions/24859749/how-to-find-out-which-fonts-are-available-in-qml
// Posted by Mido
// Retrieved 2025-11-05, License - CC BY-SA 4.0
import QtQuick
import Quickshell
import Quickshell.Io
ListView {
    anchors.fill: parent; 
    model: Qt.fontFamilies()

    delegate: Item {
        height: 40; 
        width: ListView.view.width
        Text {
            font.family: modelData
            anchors.centerIn: parent
            text: modelData;
        }
    }
}
