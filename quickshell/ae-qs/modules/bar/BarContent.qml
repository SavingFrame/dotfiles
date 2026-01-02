import qs.widgets
import qs.settings
import qs.modules.bar.widgets
import QtQuick
import QtQuick.Layouts

// I'm too lazy to modify all modules sooo.... I will fix it later but not right now.

Item {

    property bool isHorizontal: Shell.flags.bar.position === "top" || Shell.flags.bar.position === "bottom"

    // Horizontal Bar Content

    Row {
        id: hLeftRow
        visible: isHorizontal
        anchors.left: parent.left
        anchors.leftMargin: Shell.flags.bar.density * 0.3
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        Glyph{}
        ActiveTopLevel{}
    }

    Row {
        id: hCenterRow
        visible: isHorizontal
        anchors.centerIn: parent
        spacing: 4
        //SystemUsage{}
        Media{}
        Workspaces{}
        Clock{}
        Utilities{}
        Battery{}
    }

    RowLayout {
        id: hRightRow
        visible: isHorizontal
        anchors.right: parent.right
        anchors.rightMargin: Shell.flags.bar.density * 0.3
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        SystemTray{}
        BluetoothWifi{}
    }


    // Vertical Bar Content

    Glyph {
        visible: !isHorizontal
        anchors.top: parent.top
        anchors.topMargin: Shell.flags.bar.density * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: 360               
    }

    Workspaces{
        visible: !isHorizontal
        anchors.top: parent.top
        anchors.topMargin: Shell.flags.bar.density * 3.4
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: 90
    }

    ActiveTopLevel {
        visible: !isHorizontal
        anchors.centerIn: parent 
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: 35
        rotation: 90
    }

    SystemTray {
        visible: !isHorizontal
        anchors.bottom: parent.bottom 
        anchors.bottomMargin: Shell.flags.bar.density * 3.8
        anchors.horizontalCenter: parent.horizontalCenter        
    }

    Clock {
        visible: !isHorizontal
        anchors.bottom: parent.bottom 
        anchors.bottomMargin: Shell.flags.bar.density * 2.8
        anchors.horizontalCenter: parent.horizontalCenter
    }

    BluetoothWifi {
        visible: !isHorizontal
        anchors.bottom: parent.bottom 
        anchors.bottomMargin: Shell.flags.bar.density * 1.4
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: 90
    }

    PowerMenuToggle {
        visible: !isHorizontal
        anchors.bottom: parent.bottom 
        anchors.bottomMargin: Shell.flags.bar.density * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: 360        
    }

    Battery {
        visible: !isHorizontal
        anchors.top: parent.top
        anchors.topMargin: Shell.flags.bar.density * 6.6
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: 90        
    }


    RControl {
        visible: isHorizontal
    }
    LControl {
        visible: isHorizontal
    }
}
