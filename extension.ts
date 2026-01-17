import vscode from "vscode";
import path from "path";
import fs from "fs";

import WebView from "./scripts/classes/web-view";
import VscManager from "./scripts/classes/vsc-manager";
import initializeModViewMain from "./ModView/mod-view-main/initialize";


// initialize mod views
const mainModview = new WebView("mod-view-main", "Mod View");

/** Entry point for the extension.
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code
 * @returns {void}
 */

function activate(context: vscode.ExtensionContext): void {
    const vscManager = new VscManager(context);

    // if no workspace folders are open, exit early
    if (!vscManager.workspaceFolders) {
        console.log("\x1b[33mNo workspace folders found\x1b[0m");
        return;
    }
    // if info.txt doesn't exist, exit early
    // this should already be handled by the activationEvents in package.json, but this is a fallback
    if (!fs.existsSync(path.join(vscManager.projectPath, "info.txt"))) {
        console.log("\x1b[33mNo Teardown mod detected in workspace\x1b[0m");
        return;
    }

    console.log(`\x1b[32mTeardown mod detected at: \x1b[96m${vscManager.projectPath}\x1b[0m`);

    // initialize main mod view
    initializeModViewMain(mainModview, vscManager);

    // register command to open the Mod View
    vscManager.registerCommand("teardownModding.openModView", () => {
        mainModview.open(context);
    });

    // open Mod View by default if the setting is enabled
    const shouldOpenByDefault = vscManager.getSetting("teardownModding.openModViewByDefault", false);
    if (shouldOpenByDefault) {
        mainModview.open(context);
        console.log("\x1b[32mOpened Mod View by default (setting enabled)\x1b[0m");
    } else {
        vscManager.showInformationMessage(
            "Teardown Mod detected in workspace.",
            [{ name: "Open Mod View", action: () => mainModview.open(context) }]
        );
    }
}

/** Cleanup function called when the extension is deactivated.
 * @returns {void}
 */
function deactivate(): void { }

module.exports = {
    activate,
    deactivate
};