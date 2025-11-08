import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland


// no more time object
Item {
    property int model: Hyprland.focusedWorkspace?.id ?? 1
    width:100
    height: 100
    Text {
        text: model
        anchors.centerIn: parent
        color: "red"
        font.pointSize:60
    }
}
/* ListView {
    anchors.fill: parent; 
    model: Hyprland.workspaces.values.reduce((acc, curr) => {
    acc[curr.id] = curr.lastIpcObject.windows > 0;
    return acc;
    }, {})
    delegate: Item {
        height: 40; 
        width: ListView.view.width
        Text {
            font.family: Appearance.mainfontfamily
            anchors.centerIn: parent
            text: model;
            font.pointSize:60
            color:"red"
        }
    }
}*/