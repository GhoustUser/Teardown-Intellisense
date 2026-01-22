import vscode from "vscode";
import path from "path";
import fs from "fs";

import VscManager from "./scripts/vsc-manager";
import { configureTDIntellisense } from "./scripts/scripting-api";


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
    // this should already be handled by the "activationEvents" in `package.json`, but this is a fallback
    if (!fs.existsSync(path.join(vscManager.projectPath, "info.txt"))) {
        return;
    }

    // register command to toggle intellisense setting
    registerToggleIntellisenseCommand(vscManager);

    // make sure the teardownDirectory setting is set
    const gameDirectory: string = vscManager.getSetting("TeardownIntellisense.teardownDirectory", "");
    if (!validateTeardownDirectory(gameDirectory)) {
        // check default directory
        const defaultPath = findTeardownDirectory();
        if (defaultPath) {
            vscManager.updateSetting("TeardownIntellisense.teardownDirectory", defaultPath, true);
            vscManager.showInformationMessage(
                `Found default Teardown directory: ${defaultPath}`, []
            );

            // if the setting is not set, prompt the user to enable intellisense
            if (vscManager.getSetting("TeardownIntellisense.showPrompt", false)) {
                ShowWorkspaceIntellisensePrompt(vscManager);
            }
        }
        // if no default directory found, prompt user to set it
        else {
            vscManager.showInformationMessage(
                "Teardown directory is not set. Please set it in the extension settings to enable intellisense.",
                [
                    { name: "Settings", action: () => vscManager.openUserSettingsUI("TeardownIntellisense.teardownDirectory") }
                ]
            )
        }
    }
    // if a Teardown mod is detected in the workspace, prompt to enable intellisense
    else if (vscManager.getSetting("TeardownIntellisense.enableIntellisense", false)) {
        // enable intellisense if the setting is already enabled
        configureTDIntellisense(true, vscManager);
    }

    // listen for changes to the enableIntellisense setting
    vscManager.onWorkspaceSettingChanged("TeardownIntellisense.enableIntellisense", (newValue: boolean) => {
        configureTDIntellisense(newValue, vscManager);
    });
    // listen for changes to the teardownDirectory setting
    vscManager.onUserSettingChanged("TeardownIntellisense.teardownDirectory", (newValue: string) => {

        if (!validateTeardownDirectory(newValue)) {
            // check default directory
            const defaultPath = findTeardownDirectory();
            if (defaultPath) {
                vscManager.showInformationMessage(
                    "The current Teardown directory setting is invalid. Please check the path and try again.",
                    [
                        { name: "Use Default", action: () => vscManager.updateSetting("TeardownIntellisense.teardownDirectory", defaultPath, true) },
                        { name: "Settings", action: () => vscManager.openUserSettingsUI("TeardownIntellisense.teardownDirectory") }
                    ]
                );
            }
            else {
                vscManager.showInformationMessage(
                    "The current Teardown directory setting is invalid. Please check the path and try again.",
                    [
                        { name: "Settings", action: () => vscManager.openUserSettingsUI("TeardownIntellisense.teardownDirectory") }
                    ]
                );
            }
            return;
        }

        // reconfigure intellisense with the new directory
        if (vscManager.getSetting("TeardownIntellisense.showPrompt", false))
            ShowWorkspaceIntellisensePrompt(vscManager);
        else
            configureTDIntellisense(vscManager.getSetting("TeardownIntellisense.enableIntellisense", false), vscManager);
    });

    // if setting is enabled, configure intellisense on activation
    const enableIntellisense: boolean = vscManager.getSetting("TeardownIntellisense.enableIntellisense", false);
    if (enableIntellisense) {
        configureTDIntellisense(enableIntellisense, vscManager);
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

function ShowWorkspaceIntellisensePrompt(vscManager: VscManager): void {
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

function validateTeardownDirectory(dir: string): boolean {
    // check if the directory exists
    if (!fs.existsSync(dir)) return false;
    // check for required subdirectories/files
    const requiredPaths = [
        path.join(dir, "data", "td_vscode_plugin.lua"),
        path.join(dir, "data", "script_defs.lua"),
        path.join(dir, "data", "voxscript_defs.lua")
    ];
    for (const requiredPath of requiredPaths) {
        if (!fs.existsSync(requiredPath)) return false;
    }
    return true;
}

function findTeardownDirectory(): string | null {
    for (let i = 0; i < 4; i++) {
        const driveLetter = String.fromCharCode(67 + i); // C, D, E, F
        const possiblePaths = [
            `${driveLetter}:/Program Files (x86)/Steam/steamapps/common/Teardown`,
            `${driveLetter}:/Program Files/Steam/steamapps/common/Teardown`
        ];
        for (const possiblePath of possiblePaths) {
            if (validateTeardownDirectory(possiblePath)) {
                return possiblePath;
            }
        }
    }
    return null;
}

function registerToggleIntellisenseCommand(vscManager: VscManager): void {
    // register command to toggle intellisense setting
    vscManager.registerCommand("TeardownIntellisense.toggleIntellisense", () => {
        const currentSetting = vscManager.getSetting("TeardownIntellisense.enableIntellisense", false);
        // show quick pick to enable/disable intellisense
        vscode.window.showQuickPick(
            [(currentSetting ? 'Disable Teardown Intellisense' : 'Enable Teardown Intellisense')],
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
