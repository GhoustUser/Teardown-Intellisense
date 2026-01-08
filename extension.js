const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const WebView = require("./ModView/WebView.js");
const VscManager = require("./scripts/vsc-manager.js");

const modviews = {
    /** 
     * The main Mod View.
     * @type {WebView|null}
     */
    main: new WebView(
        "main",
        "Mod View",
        "mod-view-main"
    )
}

/**
 * Entry point for the extension.
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code
 * @returns {void}
 */

function activate(context) {
    const vscManager = new VscManager(context);

    // check if there are workspace folders open
    if (!vscManager.workspaceFolders) {
        console.log("No workspace folders found.");
        return;
    }

    // if info.txt doesn't exist, exit early
    if (!fs.existsSync(path.join(vscManager.projectPath, "info.txt"))) {
        console.log("No Teardown mod detected in workspace.");
        return;
    }

    modviews.main.onOpen = () => {
        // read the contents of info.txt and send it to the webview
        const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
        if (fs.existsSync(infoTxtPath)) {
            const infoTxtContent = fs.readFileSync(infoTxtPath, "utf8");
            modviews.main.send("infoTxt", infoTxtContent);
        }
        // send the mod icon path if it exists
        let modIconPath = path.join(vscManager.projectPath, "preview.png");
        if (!fs.existsSync(modIconPath)) {
            modIconPath = path.join(vscManager.projectPath, "preview.jpg");
        }
        if (fs.existsSync(modIconPath)) {
            const modIconUri = modviews.main.getWebviewUri(modIconPath);
            modviews.main.send("modIconPath", modIconUri.toString());
        }
        console.log("Mod View opened.");
    };

    modviews.main.onClose = () => {
        console.log("Mod View closed.");
    };

    modviews.main.onMessage = (type, data) => {
        // handle different message types
        switch (type) {
            case "reload":
                // reload the webview content
                modviews.main.reload(context);
                modviews.main.setTitle(modviews.main.defaultTitle);
                break;
            case "unsavedChanges":
                console.log("Unsaved changes:", data);
                // mark the main mod view as having unsaved changes
                // by making the dab title italic and adding asterisk
                modviews.main.setTitle(data ? modviews.main.defaultTitle + " (unsaved)" : modviews.main.defaultTitle);
                break;
            case "saveModInfo":
                // save the mod info to info.txt
                //const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
                //fs.writeFileSync(infoTxtPath, data, "utf8");
                console.log("Mod info saved:\n", data);
                vscode.window.showInformationMessage("Mod info saved successfully.");
                // reset the unsaved changes indicator
                modviews.main.setTitle(modviews.main.defaultTitle);
                break;
            default:
                console.log("Unhandled message type in Mod View:", type, data);
                break;
        }
    };

    // register command to open the Mod View
    vscManager.registerCommand("teardownModding.openModView", () => {
        modviews.main.open(context);
    });

    // open Mod View by default if the setting is enabled
    if (vscManager.getSetting("teardownModding.openModViewByDefault", false)) {
        modviews.main.open(context);
    }
    // otherwise, show an information message with an option to open the Mod View
    else {
        vscManager.showInformationMessage(
            "Teardown Mod detected in workspace.",
            [{ name: "Open Mod View", action: () => modviews.main.open(context) }]
        );
    }
}

/**
 * Cleanup function called when the extension is deactivated.
 * @returns {void}
 */
function deactivate() { }

module.exports = {
    activate,
    deactivate
};