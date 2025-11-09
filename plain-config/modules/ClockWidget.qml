// ClockWidget.qml
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import qs.modules.components
// pragma Singleton

Item {
    // allows for button text and 
    property string timetext: Time.time
    property string datetext: Time.date
    property real timewidth: 30
    property real fontsize: Appearance.mainfontsize
    property bool help: true
    id: root
    // timer to change time back to time since 
    // for some reason the button forces it to stay the same
    // even if time changes
    RoundButton {
        anchors.centerIn: tex
        anchors.fill: tex.content
        // Layout.fillHeight: true
        width: tex.contentWidth + Appearance.mainfontsize * 0.85
        height: tex.contentHeight + Appearance.mainfontsize * 0.8
        radius: Appearance.mainfontsize * 0.8
        flat: true
        opacity: 0.25
        onClicked: {
            tex.text = help ? Qt.binding(function(){return datetext}) : Qt.binding(function(){return timetext})
            help = !help
            // if (tex.text == timetext)
            //     tex.text = Qt.binding(function(){return datetext})
            // else
            //     tex.text = tex.text = Qt.binding(function(){return timetext})
        }
    }
    Text {
        id: tex
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: timetext
        font.family:Appearance.mainfontfamily
        font.pointSize: fontsize
        wrapMode: Text.Wrap
        width: timewidth
        color: Appearance.maintext
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
    }
}