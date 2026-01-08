const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const WebView = require("./ModView/WebView.js");
const VscManager = require("./scripts/vsc-manager.js");

let ModViews = {
    /** 
     * The main Mod View.
     * @type {WebView|null}
     */
    main: null
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

    // initialize mod views
    ModViews.main = new WebView(
        vscManager.context,
        "main",
        "Teardown Mod View",
        "mod-view-main"
    );

    vscManager.registerCommand("teardownModding.openModView", () => {
        openModView(vscManager);
    });

    // Open Mod View by default if the setting is enabled
    if (vscManager.getSetting("teardownModding.openModViewByDefault", false)) {
        openModView(vscManager);
    }
    // Otherwise, show an information message with an option to open the Mod View
    else {
        vscManager.showInformationMessage(
            "Teardown Mod detected in workspace.",
            [{ name: "Open Mod View", action: () => openModView(vscManager) }]
        )
    }
}

/**
 * Opens the main Mod View webview.
 * @param {VscManager} vscManager - The VscManager instance.
 */
function openModView(vscManager) {
    const modView = new WebView(
        vscManager.context,
        "main",
        "Teardown Mod View",
        "mod-view-main"
    );

    const isModViewOpen = modView.open();

    if (!isModViewOpen) {
        console.error("Failed to create webview panel.");
        return;
    }

    // Read the contents of info.txt and send it to the webview
    const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
    if (fs.existsSync(infoTxtPath)) {
        const infoTxtContent = fs.readFileSync(infoTxtPath, "utf8");
        modView.sendUpdate("infoTxt", infoTxtContent);
    }
    // Send the mod icon path if it exists
    let modIconPath = path.join(vscManager.projectPath, "preview.png");
    if (!fs.existsSync(modIconPath)) {
        modIconPath = path.join(vscManager.projectPath, "preview.jpg");
    }
    if (fs.existsSync(modIconPath)) {
        const modIconUri = modView.getWebviewUri(modIconPath);
        modView.sendUpdate("modIconPath", modIconUri.toString());
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