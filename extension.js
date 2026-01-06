const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const { IsScriptingApiLoaded, LoadScriptingApi } = require("./scripts/load-lua-api.js");
const { LoadModData } = require("./scripts/load-mod-data.js");
const CustomEditor = require('./CustomEditors/CustomEditor');


const { workspaceFolders } = vscode.workspace;
const workspaceSettings = vscode.workspace.getConfiguration("", null);

const moddingEnabled = workspaceSettings.get("TeardownModding.enabled", false);

/**
 * Entry point for the extension.
 * 
 * Initializes the extension by adding the Lua API path to the workspace library configuration.
 * Retrieves the existing workspace library paths from Lua configuration and appends the extension's
 * lua directory to the library array if it's not already included.
 * 
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code
 * @returns {void}
 */

function activate(context) {
    // check project root for 'info.txt' to determine if it's a Teardown mod
    if (!workspaceFolders) {
        console.log("No workspace folders found.");
        return;
    }

    const rootPath = workspaceFolders[0].uri.fsPath;
    const infoTxtPath = path.join(rootPath, "info.txt");
    // if info.txt doesn't exist, exit early
    if (!fs.existsSync(infoTxtPath)) {
        console.log("No Teardown mod detected in workspace.");
        return;
    }

    // check .vscode settings for Teardown Modding Extension prompted flag
    const hasPrompted = workspaceSettings.get("TeardownModding.hasPrompted", false);
    if (!hasPrompted) {
        // show a yes/no prompt to load the Lua API if not already loaded
        console.log("Prompting user to load Teardown Modding Extension...");

        vscode.window.showInformationMessage(
            "Enable Teardown Modding Extension for this workspace?",
            { modal: true, detail: "Found info.txt in workspace root.\nChoice will be saved in workspace settings." },
            "Yes", "No"
        ).then(selection => {
            // update hasPrompted flag in workspace settings
            workspaceSettings.update("TeardownModding.hasPrompted", true, vscode.ConfigurationTarget.Workspace);

            // handle user selection
            switch (selection) {
                case "Yes":
                    workspaceSettings.update("TeardownModding.enabled", true, vscode.ConfigurationTarget.Workspace);
                    break;
                case "No":
                    workspaceSettings.update("TeardownModding.enabled", false, vscode.ConfigurationTarget.Workspace);
                    return; // exit early
                case null:
                    return; // user dismissed the prompt
            }

            // Prompt for mod type and load relevant data
            vscode.window.showInformationMessage(
                "Select the type of mod you are working on:",
                { modal: true, detail: "This will enable specific features based on your mod type." },
                "Content Mod", "Global Mod", "Character Mod"
            ).then(modSelection => {
                switch (modSelection) {
                    case "Content Mod":
                        workspaceSettings.update("TeardownModding.modType", "content", vscode.ConfigurationTarget.Workspace);
                        break;
                    case "Global Mod":
                        workspaceSettings.update("TeardownModding.modType", "global", vscode.ConfigurationTarget.Workspace);
                        break;
                    case "Character Mod":
                        workspaceSettings.update("TeardownModding.modType", "character", vscode.ConfigurationTarget.Workspace);
                        break;
                }
            });

        });
    }
    if (moddingEnabled) {
        LoadModData(context, rootPath);
        RegisterCustomEditors(context)
        // Load the Lua API into the workspace configuration if not already loaded
        if (!IsScriptingApiLoaded(context)) {
            LoadScriptingApi(context);
        }
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

function RegisterCustomEditors(context) {
    // info.txt custom editor
    const customEditor = new CustomEditor(
        context,
        "info.txt",
        (html, filePath, fileContent) => html
            .replace(/<FileContent>/g, fileContent)
    ).register('CustomEditor-info_txt');
}