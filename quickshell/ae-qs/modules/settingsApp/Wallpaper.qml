import qs.services
import qs.widgets 
import qs.settings
import Quickshell.Widgets
import Quickshell
import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import QtQuick.Dialogs

ContentMenu {
    title: "Wallpaper"
    description: "Manage your wallpapers"

    component Anim: NumberAnimation {
        duration: 400
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.standard
    }

    // Interval options in milliseconds
    readonly property var intervalOptions: [
        { label: "1 minute", value: 60000 },
        { label: "5 minutes", value: 300000 },
        { label: "15 minutes", value: 900000 },
        { label: "30 minutes", value: 1800000 },
        { label: "1 hour", value: 3600000 },
        { label: "2 hours", value: 7200000 },
        { label: "6 hours", value: 21600000 },
        { label: "12 hours", value: 43200000 },
        { label: "24 hours", value: 86400000 }
    ]

    function getIntervalIndex(value) {
        for (let i = 0; i < intervalOptions.length; i++) {
            if (intervalOptions[i].value === value) return i;
        }
        return 2; // Default to 15 minutes
    }

    FolderDialog {
        id: folderDialog
        title: "Select Wallpaper Folder"
        onAccepted: {
            Shell.setNestedValue("background.slideshowFolder", selectedFolder.toString().replace("file://", ""));
            Quickshell.execDetached(["qs", "-c", "ae-qs", "ipc", "call", "background", "rescan"]);
        }
    }

    ContentCard {
        ClippingRectangle {
            id: wpContainer
            Layout.alignment: Qt.AlignHCenter
            width: root.screen.width / 2
            height: width * root.screen.height / root.screen.width
            radius: 10
            color: Appearance.m3colors.m3surfaceContainer

            StyledText {
                text: "Current Wallpaper:"
                font.pixelSize: 20
                font.bold: true
            }

            StyledRect {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignCenter
                id: wpPreview
                anchors.fill: parent
                radius: 12
                color: Appearance.m3colors.m3paddingContainer
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: wpPreview.width
                        height: wpPreview.height
                        radius: wpPreview.radius
                    }
                }

                StyledText {
                    opacity: !Shell.flags.background.wallpaperEnabled ? 1 : 0
                    Behavior on opacity { Anim {} }
                    font.pixelSize: Appearance.font.size.title
                    text: "Wallpaper Manager Disabled"
                    anchors.centerIn: parent
                }
                Image {
                    opacity: Shell.flags.background.wallpaperEnabled ? 1 : 0
                    Behavior on opacity { Anim {} }
                    anchors.fill: parent
                    source: Shell.flags.background.wallpaperPath
                    fillMode: Image.PreserveAspectCrop
                    cache: true
                    opacity: 0.9
                }
            }
        }


        StyledButton {
            icon: "wallpaper"
            text: "Change Wallpaper"
            Layout.fillWidth: true 
            onClicked: Quickshell.execDetached(["qs", "-c", "ae-qs", "ipc", "call", "background", "change"])
        }

        StyledSwitchOption {
            title: "Enabled";
            description: "Enabled or disable wallpaper manager."
            prefField: "background.wallpaperEnabled"
        }
    }

    // Slideshow Settings
    ContentCard {
        StyledText {
            text: "Slideshow"
            font.pixelSize: Appearance.font.size.large
            font.bold: true
        }

        StyledSwitchOption {
            title: "Enable Slideshow"
            description: "Automatically cycle through wallpapers in a folder."
            prefField: "background.slideshowEnabled"
        }

        // Folder selection
        RowLayout {
            Layout.fillWidth: true
            spacing: Appearance.margin.normal
            opacity: Shell.flags.background.slideshowEnabled ? 1 : 0.5

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                StyledText {
                    text: "Wallpaper Folder"
                    font.pixelSize: Appearance.font.size.normal
                    font.bold: true
                }

                StyledText {
                    text: Shell.flags.background.slideshowFolder || "Not selected"
                    font.pixelSize: Appearance.font.size.small
                    color: Appearance.colors.colSubtext
                    elide: Text.ElideMiddle
                    Layout.fillWidth: true
                }
            }

            StyledButton {
                icon: "folder_open"
                text: "Browse"
                enabled: Shell.flags.background.slideshowEnabled
                onClicked: folderDialog.open()
            }
        }

        // Interval selection
        RowLayout {
            Layout.fillWidth: true
            spacing: Appearance.margin.normal
            opacity: Shell.flags.background.slideshowEnabled ? 1 : 0.5

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                StyledText {
                    text: "Change Interval"
                    font.pixelSize: Appearance.font.size.normal
                    font.bold: true
                }

                StyledText {
                    text: "How often to change the wallpaper."
                    font.pixelSize: Appearance.font.size.small
                    color: Appearance.colors.colSubtext
                }
            }

            StyledDropDown {
                id: intervalDropdown
                enabled: Shell.flags.background.slideshowEnabled
                model: intervalOptions.map(opt => opt.label)
                currentIndex: getIntervalIndex(Shell.flags.background.slideshowInterval)
                onSelectedIndexChanged: (index) => {
                    Shell.setNestedValue("background.slideshowInterval", intervalOptions[index].value);
                }
            }
        }

        // Order selection
        RowLayout {
            Layout.fillWidth: true
            spacing: Appearance.margin.normal
            opacity: Shell.flags.background.slideshowEnabled ? 1 : 0.5

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                StyledText {
                    text: "Order"
                    font.pixelSize: Appearance.font.size.normal
                    font.bold: true
                }

                StyledText {
                    text: "How to pick the next wallpaper."
                    font.pixelSize: Appearance.font.size.small
                    color: Appearance.colors.colSubtext
                }
            }

            StyledDropDown {
                id: orderDropdown
                enabled: Shell.flags.background.slideshowEnabled
                model: ["Random", "Sequential"]
                currentIndex: Shell.flags.background.slideshowOrder === "random" ? 0 : 1
                onSelectedIndexChanged: (index) => {
                    Shell.setNestedValue("background.slideshowOrder", index === 0 ? "random" : "sequential");
                }
            }
        }

        // Next wallpaper button
        StyledButton {
            icon: "skip_next"
            text: "Next Wallpaper"
            Layout.fillWidth: true
            enabled: Shell.flags.background.slideshowEnabled
            onClicked: Quickshell.execDetached(["qs", "-c", "ae-qs", "ipc", "call", "background", "next"])
        }

        // Keybind hint
        StyledText {
            visible: Shell.flags.background.slideshowEnabled
            text: "Tip: You can bind a key in Hyprland to change wallpaper:\nbind = SUPER, W, exec, qs -c ae-qs ipc call background next"
            font.pixelSize: Appearance.font.size.small
            color: Appearance.colors.colSubtext
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
    }
}
