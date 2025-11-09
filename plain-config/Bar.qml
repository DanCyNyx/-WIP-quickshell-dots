// Bar.qml
// File for all the layout and coloring parts of the bar

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.modules
import qs.modules.components

Scope {
    // no more time object
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            id: panel
            screen: modelData
            implicitHeight: screen.height * (2.32/100) // 2.32% of the screens width is the vert bar
            color: Appearance.mainpanel
            // surfaceFormat {opaque:false}
            anchors {
                top: true
                left: true
                right: true
            }
            Rectangle {
                id:barrect
                anchors.fill: parent
                // can round corners of rectangle but not PanelWindow
                radius: 0
                color: Appearance.maincolor
                opacity: Appearance.mainopacity
                // color: '#242313'
            }
            RowLayout {
                id: leftrow
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    // rightMargin: parent.width/70
                }
                opacity: Appearance.mainTextOpacity
                implicitHeight: barrect.height
                TempWorkspace {
                    // Layout vars to align widget
                    Layout.alignment: Qt.AlignVCenter
                    Layout.maximumWidth: itemwidth*20
                    // Layout.topMargin: barrect.height * 0.3
                    Layout.leftMargin: 10
                    // values supplied to TempWorkspace Widget
                    itemwidth: Appearance.mainfontsize*1.1 // 1.95 with text
                    itemheight: itemwidth
                    rectrad: itemwidth * 0.5
                }
            }
            RowLayout {
                id: timerow
                anchors.centerIn: parent
                spacing: parent.width/250
                opacity: Appearance.mainTextOpacity
                
                ClockWidget {
                    Layout.alignment: Qt.AlignVCenter
                    //timetext: Time.time
                    timewidth: timerow.width
                    // font.pointSize: Appearance.mainfontsize+2
                }
            }
            RowLayout {
                id: rightrow
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: parent.width/70
                }
                spacing: parent.width/250
                opacity: Appearance.mainTextOpacity
                BatteryWidget {
                    // spacing: screen.width / 70
                    // text: "; The battery is" + " " + Math.round(Battery.percentage*100) + "%"
                    // font.pointSize: Appearance.mainfontsize+2
                    implicitWidth: screen.width/10
                    implicitHeight: screen.height/10
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }
}
