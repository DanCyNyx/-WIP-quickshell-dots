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
    id: root
    // timer to change time back to time since 
    // for some reason the button forces it to stay the same
    // even if time changes
    Timer {
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            if (tex.text !== timetext && tex.text!== datetext)
            tex.text = timetext
        }
    }
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
            if (tex.text == timetext)
                tex.text = datetext
            else
                tex.text = timetext
            
        }
    }

    Text {
        id: tex
        // we no longer need time as an input
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        // directly access the time property from the Time singleton
        text: timetext
        font.family:Appearance.mainfontfamily
        font.pointSize: Appearance.mainfontsize
        wrapMode: Text.Wrap
        width: timewidth
        
        color: Appearance.maintext
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        //color: "#333333"
    }
}