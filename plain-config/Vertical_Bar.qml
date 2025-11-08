// Vertical_Bar.qml
// File for all the layout and coloring parts of the bar

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules
import qs.modules.components


Scope {
    // no more time object
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData
            // implicitHeight: 30
            implicitWidth: screen.width * (1.7/100) // 2% of the screens width is the vert bar
            color: Appearance.mainpanel
            // surfaceFormat {opaque:false}
            //color: '#ebe5ac'
            anchors {
                top: true
                //right: true
                left: true
                bottom: true
                
            }
            Rectangle {
                anchors.fill: parent
                radius: 0
                color: Appearance.maincolor
                opacity: Appearance.mainopacity
            }
            ColumnLayout {
                id: middlecolumn
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent
                spacing: parent.height/250
                opacity: Appearance.mainTextOpacity
                ClockWidget {
                    // no more time binding
                    // Set the rotation for vertical text
                    /*transform: Rotation {
                        angle: 45 // Rotate by 90 degrees for vertical text
                        axis{x: 0; y: 0; z: 1}
                        origin.x: width 
                        origin.y: height
                    }
                    font.pointSize: Appearance.mainfontsize
                    wrapMode: Text.Wrap
                    color: Appearance.maintext */
                    // transform: Rotation {origin.x: {column.width/2} origin.y: {column.height/2} angle: 270}
                    timetext: VertTime.time
                    datetext: VertTime.date
                    //root.font.pointSize: Appearance.mainfontsize + 1.5
                    Layout.minimumWidth: 16
                    Layout.maximumWidth: 30
                    Layout.alignment: Qt.AlignHCenter 
                }
                /* BatteryWidget {
                    // anchors.horizontalCenter: parent
                    Layout.alignment: Qt.AlignHCenter
                }*/
            }
            ColumnLayout {
                id: bottomcolumn
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.verticalCenter: parent.verticalCenter
                anchors.bottom: parent.bottom
                spacing: parent.height/250
                opacity: Appearance.mainTextOpacity
                anchors.bottomMargin: parent.height/30
                VertBatteryWidget{
                    implicitWidth: screen.width/10
                    implicitHeight: screen.height/10
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
