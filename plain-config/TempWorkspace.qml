//  TempWorkspace.qml
// Temporary workspace file for testing stuff till i make a better layout and file
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.modules
import qs.modules.components

Item {
    property real itemwidth: (Appearance.mainfontsize + 15)
    property real itemheight: itemwidth
    property real rectrad: itemwidth/2
    property var listorient: ListView.Horizontal
    width: itemwidth*10
    height: itemheight*10
    ListView {
        model: Hyprland.workspaces
        orientation: listorient
        spacing: 6
        anchors.fill: parent
        // anchors.fill: parent
        delegate: Item {
            id: root
            property string ids: modelData.id
            property string actives: modelData.active
            property string color1: Appearance.maintext
            // property string rectcolor: "transparent"
            readonly property bool isworkspaceactive: Hyprland.focusedWorkspace.id == root.ids
            // breaks things anchors.fill: parent
            implicitWidth: itemwidth
            implicitHeight: itemheight
            Rectangle {
                id: textbg
                anchors.fill: textmouse
                color: isworkspaceactive? Appearance.maintext: Appearance.mainworkspace
                radius: rectrad
                opacity:isworkspaceactive? 0.9 : 1
            }
            MouseArea {
                id: textmouse
                //anchors.centerIn: texts
                anchors.fill: root
                hoverEnabled: true
                onEntered: {
                    textbgoverlay.color = "black";
                    //texts.color = "red"; //Qt.binding(function(){return color1})
                }
                onExited: {
                    textbgoverlay.color = "transparent";
                    //texts.color = Qt.binding(function(){return !isworkspaceactive ? Appearance.maintext : Appearance.maincolor})
                }
                onClicked: {
                    if (Hyprland.focusedWorkspace.id != root.ids) Hyprland.dispatch(`workspace ${root.ids}`)
                    else return
                }
                
                Rectangle {
                    id: textbgoverlay
                    anchors.fill: parent
                    radius: textbg.radius
                    color: "transparent"
                    opacity: 0.4
                }
            }
            // text for the colors of the stuff
            /*
            Text {
                id: texts
                font.family: Appearance.mainfontfamily
                anchors.centerIn: parent
                // anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                text: root.ids
                topPadding: itemheight*0.13
                font.pointSize: Appearance.mainfontsize
                color: !isworkspaceactive ? Appearance.maintext : Appearance.maincolor
            }*/
        }
    }
}
