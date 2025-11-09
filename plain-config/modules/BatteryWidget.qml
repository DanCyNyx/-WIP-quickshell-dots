// BatteryWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.UPower
//pragma Singleton
import qs.modules.components
import qs.modules
import qs.modules.svgicons

/* Rectangle {
    id: baserect
    implicitHeight: 204
    implicitWidth: 852
    color: 'transparent'
    Rectangle {
        id: background
        anchors.fill: parent
        color: Appearance.maincolor
        opacity: Appearance.mainopacity
    }*/
RowLayout {
    id: row
    // anchors.right: parent
    spacing: Appearance.mainfontsize * 2 // find a way to make this be based on screen size
    implicitHeight: 100 // random height, must assign in bar
    implicitWidth: 100 // random width, must assign in bar
    // Displays Text of the battery percentage 
    Text {
        id:battTex
        text: Math.round(Battery.percentage*100) + "%"
        font.family: Appearance.mainfontfamily
        font.pointSize: Appearance.mainfontsize
        Layout.alignment: Qt.AlignVCenter
        wrapMode: Text.Wrap
        color: Appearance.maintext
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
    }
    Item {
        Layout.alignment: Qt.AlignVCenter
        // Battery icon creation file
        BatteryHorizontal {
            id: battIcon
            implicitHeight: 5.5 * Appearance.mainfontsize / 2
            implicitWidth: height * 1.2
            anchors.centerIn: parent
        }
        // Rectangle to act as charging bar
        Rectangle {
            id: battbar
            implicitHeight: battIcon.height - battIcon.height/1.285
            // Battery.percentage * conversion for icon width to bar max width
            implicitWidth: (battIcon.width/1.8) * Battery.percentage
            anchors {
                left: battIcon.left
                top: battIcon.top
                // Margins to prevent bar from going beyond icon area
                topMargin: battIcon.height / 2.58
                leftMargin: battIcon.width / 5.6 
            }
            
            color: Appearance.maintext
            radius: Appearance.mainfontsize / 9
        }
    }
}