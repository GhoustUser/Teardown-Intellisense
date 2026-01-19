import vscode from "vscode";
import path from "path";
import fs from "fs";

import VscManager from "./scripts/vsc-manager";
import { enableScriptingApi } from "./scripts/scripting-api";


/** Entry point for the extension.
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code
 * @returns {void}
 */

function activate(context: vscode.ExtensionContext): void {
    const vscManager = new VscManager(context);

    // if no workspace folders are open, exit early
    if (!vscManager.workspaceFolders) {
        return;
    }
    // if info.txt doesn't exist, exit early
    // this should already be handled by the "activationEvents" in package.json, but this is a fallback
    if (!fs.existsSync(path.join(vscManager.projectPath, "info.txt"))) {
        return;
    }

    vscManager.onWorkspaceSettingChanged("teardownModding.enableScriptingAPI", (newValue: any) => {
        if (typeof newValue === "boolean") {
            enableScriptingApi(newValue, vscManager);
        }
    });

    // if the setting is not set, prompt the user to enable the scripting API
    const doShowPrompt: boolean = vscManager.getSetting("teardownModding.showPrompt", false);
    if (doShowPrompt) {
        // show prompt to enable scripting API
        vscManager.showInformationMessage(
            "Teardown Mod detected in workspace, enable intellisense for scripting API?",
            [
                { name: "Enable", action: () => vscManager.updateSetting("teardownModding.enableScriptingAPI", true) },
                { name: "Dismiss", action: () => vscManager.updateSetting("teardownModding.enableScriptingAPI", false) },
                { name: "Settings", action: () => vscManager.openWorkspaceSettingsUI("teardownModding.enableScriptingAPI") }
            ]
        ).then(selectedAction => {
            // update setting to not show the prompt again
            vscManager.updateSetting("teardownModding.showPrompt", false);
            // execute the selected action
            if (selectedAction) {
                selectedAction.action();
            }
        });
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