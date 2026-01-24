import vscode from "vscode";
import path from "path";
import fs from "fs";

import VscManager from "./scripts/vsc-manager";
import { configureTDIntellisense } from "./scripts/scripting-api";

let c: vscode.ExtensionContext | null = null;

/** Entry point for the extension.
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code
 * @returns {void}
 */

function activate(context: vscode.ExtensionContext): void {
    c = context;
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

    // register command to toggle intellisense setting
    registerToggleIntellisenseCommand(vscManager);

    // listen for changes to the `enableIntellisense` setting
    vscManager.onWorkspaceSettingChanged("TeardownIntellisense.enableIntellisense", (newValue: any) => {
        if (typeof newValue === "boolean") {
            configureTDIntellisense(newValue, vscManager);
        }
    });

    // if the setting is not set, prompt the user to enable the scripting API
    const doShowPrompt: boolean = vscManager.getSetting("TeardownIntellisense.showPrompt", false);
    if (doShowPrompt) {
        // show prompt to enable scripting API
        showWorkspaceIntellisensePrompt(vscManager);
    }
    else if (vscManager.getSetting("TeardownIntellisense.enableIntellisense", false)) {
        // configure intellisense if the setting is already enabled
        configureTDIntellisense(true, vscManager);
    }
}

/** Cleanup function called when the extension is deactivated.
 * @returns {void}
 */
function deactivate(): void {
    // disable Teardown intellisense on deactivate
    configureTDIntellisense(false, new VscManager(c!));
 }

module.exports = {
    activate,
    deactivate
};

/** Show prompt to enable Teardown intellisense in the workspace.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function showWorkspaceIntellisensePrompt(vscManager: VscManager): void {
    // show prompt to enable intellisense
    vscManager.showInformationMessage(
        "Teardown Mod detected in workspace, enable intellisense for scripting API?",
        [
            { name: "Workspace", action: () => vscManager.updateSetting("TeardownIntellisense.enableIntellisense", true, false) },
            { name: "User", action: () => vscManager.updateSetting("TeardownIntellisense.enableIntellisense", true, true) },
            { name: "Don't show again", action: () => vscManager.updateSetting("TeardownIntellisense.showPrompt", false, true) },
            { name: "Settings", action: () => vscManager.openWorkspaceSettingsUI("TeardownIntellisense.enableIntellisense") }
        ]
    ).then(selectedAction => {
        // update setting to not show the prompt again
        vscManager.updateSetting("TeardownIntellisense.showPrompt", false, false);
        // execute the selected action
        if (selectedAction) {
            selectedAction.action();
        }
    });
}

/** Register the command to toggle Teardown intellisense setting.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function registerToggleIntellisenseCommand(vscManager: VscManager): void {
    // register command to toggle intellisense setting
    vscManager.registerCommand("TeardownIntellisense.toggleIntellisense", () => {
        const currentSetting = vscManager.getSetting("TeardownIntellisense.enableIntellisense", false);
        // show quick pick to enable/disable intellisense
        vscode.window.showQuickPick(
            [(currentSetting ? 'Disable' : 'Enable') + ' Teardown Intellisense'],
            { placeHolder: 'Currently ' + (currentSetting ? 'enabled' : 'disabled') + '. Select an action:' }
        ).then(selection => {
            // handle selection
            switch (selection) {
                case 'Enable Teardown Intellisense':
                    vscManager.updateSetting("TeardownIntellisense.enableIntellisense", true, false);
                    break;
                case 'Disable Teardown Intellisense':
                    vscManager.updateSetting("TeardownIntellisense.enableIntellisense", false, false);
                    break;
            }
        });
    });
}
