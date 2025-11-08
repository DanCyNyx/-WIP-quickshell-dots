import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import qs.modules
pragma Singleton

// placeholder text
Singleton {
    id: root
    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state
    property bool isCharging: chargeState == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1
    // Battery levels to warn user
    property bool battlow: available && (percentage <= 30/100)
    property real critlevel: 10
    property bool battcritical: available && (percentage <= critlevel/100)
    // Max charge level of the laptop
    property real maxbattlevel: 60
    property bool battfull: available && (percentage >= maxbattlevel/100)
    // Time left for battery  
    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property real timeToFull: UPower.displayDevice.timeToFull
    // Suspend and sound options (to be set by a different file)
    property bool automaticSuspend: true
    property bool soundEnabled: true
    property real suspendtime: 10 // Default 10 seconds
    // Booleans to use to notify user
    property bool lowandNotCharging: battlow && !isCharging
    property bool critandNotCharging: battcritical && !isCharging && automaticSuspend
    property bool fullandCharging: battfull && isCharging
    ///////////////////////////////////
    // Booleans and output statements//
    ///////////////////////////////////
    onLowandNotChargingChanged: {
        if (!root.available || !lowandNotCharging) return;
        Quickshell.execDetached([
            "notify-send", 
            "Low battery", 
            "Consider plugging in your device", 
            "-u", "critical",
            "-a", "Shell",
            "--hint=int:transient:1",
        ])
        if (root.soundEnabled) Appearance.playSystemSound("dialog-warning");
    }

    onCritandNotChargingChanged: {
        if (!root.available || !critandNotCharging) return;
        Quickshell.execDetached([
            "notify-send", 
            "Battery is Critical", 
            ("Please charge!\nAutomatic suspend triggers in %1s").arg(suspendtime), 

            "-u", "critical",
            "-a", "Shell",
            "--hint=int:transient:1",
        ])
        if (root.soundEnabled) Appearance.playSystemSound("suspend-error");
    }
    onFullandChargingChanged: {
        if (!root.available || !fullandCharging) return;
        Quickshell.execDetached([
            "notify-send",
            /* Translation.tr(*/"Battery full",
            "Unplug the charger to preserve battery health",
            "-a", "Shell",
            "--hint=int:transient:1",
        ]);
        if (root.soundEnabled) Appearance.playSystemSound("complete");
    }
    
    onIsPluggedInChanged: {
        if (!root.available || !root.soundEnabled) return;
        if (isPluggedIn) {
            Appearance.playSystemSound("power-plug")
        } else {
            Appearance.playSystemSound("power-unplug")
        }
    }
    // Process and timer to suspend after suspendtime seconds if batt critical and not charging
    Process {
        id: battsuspend
        command: ["bash","-c", `systemctl suspend || loginctl suspend`]
        running: false
    }
    /*Timer {
        running: true
        repeat: true
        interval: 100
        onTriggered: {
            isPluggedIn = (isCharging || chargeState == UPowerDeviceState.PendingCharge)
        }
    }*/
    Timer {
        interval: 1000 * suspendtime // suspendtime seconds
        running: true
        repeat: false
        // if the battery is critical and not charging after suspend time, process runs
        onTriggered: battsuspend.running = (root.available && critandNotCharging)
    }    
}