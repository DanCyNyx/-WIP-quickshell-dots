// Bar.qml
// File for all the layout and coloring parts of the bar

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.modules
import qs.modules.components

Scope {
    // no more time object
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
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
                id: timerow
                anchors.centerIn: parent
                spacing: parent.width/250
                opacity: Appearance.mainTextOpacity
                
                ClockWidget {
                    Layout.alignment: Qt.AlignVCenter
                    timetext: Time.time
                    timewidth: timerow.width
                    // no more time binding
                    // font.pointSize: Appearance.mainfontsize+2
                    // text: "The time is" + " " + Time.time
                    
                }
                
                /*
                ClockWidget {
                    Layout.alignment: Qt.AlignVCenter
                    // no more time binding
                    // font.pointSize: Appearance.mainfontsize+2
                    // text: "The time is" + " " + Time.time
                    
                }
                */
                
            }
            RowLayout {
                id: rightrow
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:parent.right
                spacing: parent.width/250
                opacity: Appearance.mainTextOpacity
                anchors.rightMargin: parent.width/70

                BatteryWidget {
                    // spacing: screen.width / 70
                    // anchors.verticalCenter: parent
                    // text: "; The battery is" + " " + Math.round(Battery.percentage*100) + "%"
                    // font.pointSize: Appearance.mainfontsize+2
                    // anchors.right: parent.right
                    implicitWidth: screen.width/10
                    implicitHeight: screen.height/10
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }
}
