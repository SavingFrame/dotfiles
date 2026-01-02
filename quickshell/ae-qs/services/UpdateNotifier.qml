import Qt.labs.platform
import QtQuick
import Quickshell
import Quickshell.Io
import qs.settings

Item {
    // Add 'v' arg to default local version because it is not stored
    // as vX.Y.Z but X.Y.Z while on github its published as vX.Y.Z

    id: updater

    property string currentVersion: ""
    property string latestVersion: ""
    property bool notified: false

    function readLocalVersion() {
        currentVersion = "v" + Shell.flags.shellInfo.version || "";
    }

    function fetchLatestVersion() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                try {
                    const json = JSON.parse(xhr.responseText); // <-- use xhr.responseText
                    if (json.tag_name) {
                        latestVersion = json.tag_name;
                        compareVersions();
                    } else if (json.message && json.message.includes("rate limit")) {
                        console.warn("Update check skipped: GitHub API rate limit exceeded.");
                    } else {
                        console.warn("Update check returned unexpected response:", json);
                    }
                } catch (e) {
                    console.warn("Update check JSON parse failed:", xhr.responseText); // <-- also here
                }
            }
        };
        xhr.open("GET", "https://api.github.com/repos/xzepyx/aelyx-shell/releases/latest");
        xhr.send();
    }

    function compareVersions() {
        if (!currentVersion || !latestVersion)
            return ;

        if (currentVersion !== latestVersion && !notified) {
            notifyUpdate();
            notified = true;
        }
    }

    function notifyUpdate() {
        Quickshell.execDetached(["notify-send", "-a", "aelyx-shell", "Shell Update Available", "Installed: " + currentVersion + "\nLatest: " + latestVersion]);
    }

    visible: false

    Timer {
        interval: 24 * 60 * 60 * 1000 // 6 hours
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            readLocalVersion();
            fetchLatestVersion();
        }
    }

}
