import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick.Layouts
import "clock/"
import qs.settings
import qs.widgets

Scope {
    id: root

    // Slideshow state (shared across all screens)
    property var slideshowImages: []
    property int slideshowIndex: 0
    property bool slideshowReady: false
    property string slideshowError: ""

    // Function to pick and apply next wallpaper
    function nextWallpaper() {
        if (slideshowImages.length === 0) {
            slideshowError = "No images found in slideshow folder";
            return;
        }

        let nextPath;
        if (Shell.flags.background.slideshowOrder === "random") {
            const randomIndex = Math.floor(Math.random() * slideshowImages.length);
            nextPath = slideshowImages[randomIndex];
        } else {
            slideshowIndex = (slideshowIndex + 1) % slideshowImages.length;
            nextPath = slideshowImages[slideshowIndex];
        }

        Shell.setNestedValue("background.wallpaperPath", "file://" + nextPath);
        Quickshell.execDetached(["qs", "-c", "ae-qs", "ipc", "call", "global", "regenColors"]);
        slideshowTimer.restart();
    }

    // Process to recursively scan slideshow folder for images
    Process {
        id: scanFolderProc

        property string folder: Shell.flags.background.slideshowFolder

        command: ["find", folder.replace("file://", ""), "-type", "f", "-iregex", ".*\\.\\(png\\|jpg\\|jpeg\\|webp\\)$"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n").filter(line => line.length > 0);
                root.slideshowImages = lines;
                root.slideshowReady = lines.length > 0;
                root.slideshowError = lines.length === 0 ? "No images found in folder" : "";
                
                // Pick a random wallpaper on startup if slideshow is enabled
                if (root.slideshowReady && Shell.flags.background.slideshowEnabled) {
                    root.nextWallpaper();
                }
            }
        }
    }

    // Rescan when folder changes
    Connections {
        target: Shell.flags.background
        function onSlideshowFolderChanged() {
            if (Shell.flags.background.slideshowEnabled) {
                scanFolderProc.running = true;
            }
        }
        function onSlideshowEnabledChanged() {
            if (Shell.flags.background.slideshowEnabled) {
                scanFolderProc.running = true;
            }
        }
    }

    // Initial scan when shell is ready
    Connections {
        target: Shell
        function onReadyChanged() {
            if (Shell.ready && Shell.flags.background.slideshowEnabled) {
                scanFolderProc.running = true;
            }
        }
    }

    // Slideshow timer
    Timer {
        id: slideshowTimer
        running: Shell.ready && Shell.flags.background.slideshowEnabled && root.slideshowReady
        repeat: true
        interval: Shell.flags.background.slideshowInterval
        onTriggered: root.nextWallpaper()
    }

    Variants {
        model: Quickshell.screens

        StaticWindow {
            id: backgroundContainer

            required property var modelData
            property string selectedWallpaper: ""

            function applyWallpaper() {
                background.source = selectedWallpaper;
                Shell.setNestedValue("background.wallpaperPath", selectedWallpaper);
                Quickshell.execDetached(["qs", "-c", "ae-qs", "ipc", "call", "global", "regenColors"]);
                // Reset slideshow timer when manually changing wallpaper
                slideshowTimer.restart();
            }

            color: background.status === Image.Error ? Appearance.colors.colLayer2 : "transparent"
            namespace: "aelyx:background"
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            screen: modelData
            visible: Shell.ready && Shell.flags.background.wallpaperEnabled

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            Process {
                id: wallpaperProc

                command: ["bash", "-c", "~/.local/share/aelyx/scripts/background/changebg.sh"]

                stdout: StdioCollector {
                    onStreamFinished: {
                        const out = text.trim();
                        if (out !== "null" && out.length > 0) {
                            selectedWallpaper = out;
                            applyWallpaper();
                        }
                    }
                }

            }

            Image {
                id: background

                anchors.fill: parent
                width: modelData.width
                height: modelData.height
                fillMode: Image.PreserveAspectCrop
                source: Shell.flags.background.wallpaperPath
            }

            Item {
                anchors.centerIn: parent
                visible: background.status === Image.Error

                Rectangle {
                    width: 550
                    height: 400
                    radius: Appearance.rounding.windowRounding
                    color: "transparent" // It looks better somehow
                    anchors.centerIn: parent

                    ColumnLayout {
                        anchors.centerIn: parent
                        anchors.margins: Appearance.margin.normal
                        spacing: Appearance.margin.small

                        // Icon
                        MaterialSymbol {
                            text: "wallpaper"
                            font.pixelSize: Appearance.font.size.wildass
                            color: Appearance.colors.colOnLayer2
                            Layout.alignment: Qt.AlignHCenter
                        }

                        // Heading
                        StyledText {
                            text: "No Wallpaper Set"
                            font.pixelSize: Appearance.font.size.hugeass
                            font.bold: true
                            color: Appearance.colors.colOnLayer2
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter
                        }

                        // Description
                        StyledText {
                            text: "It looks like you haven't selected a wallpaper yet."
                            font.pixelSize: Appearance.font.size.small
                            color: Appearance.colors.colSubtext
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Item {
                            Layout.fillHeight: true
                        }

                        // Action
                        StyledButton {
                            text: "Set wallpaper"
                            icon: "wallpaper"
                            secondary: true
                            Layout.alignment: Qt.AlignHCenter
                            onClicked: wallpaperProc.running = true;
                        }

                    }

                }

            }

            Clock {
            }

            IpcHandler {
                function change() {
                    wallpaperProc.running = true;
                }

                function next() {
                    root.nextWallpaper();
                }

                function rescan() {
                    scanFolderProc.running = true;
                }

                target: "background"
            }

        }

    }

}
