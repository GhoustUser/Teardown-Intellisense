const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const { LoadModData } = require("./scripts/load-mod-data.js");


const { workspaceFolders } = vscode.workspace;

/**
 * Entry point for the extension.
 * 
 * Initializes the extension by adding the Lua API path to the workspace library configuration.
 * Retrieves the existing workspace library paths from Lua configuration and appends the extension's
 * lua directory to the library array if it's not already included.
 * 
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code, containing extension path and other metadata
 * @returns {void}
 */

function activate(context) {
    console.log("Activating Teardown API Extension...");
    // check project root for 'info.txt' to determine if it's a Teardown mod
    if (workspaceFolders) {
        const rootPath = workspaceFolders[0].uri.fsPath;
        const infoTxtPath = path.join(rootPath, "info.txt");
        // if info.txt exists, it's a teardown mod
        if (fs.existsSync(infoTxtPath)) {
            LoadModData(context, rootPath);
        } else {
            console.log("No Teardown mod detected in workspace.");
        }
    }

    console.log("Teardown API Extension activated");
    console.log(context.extensionPath);
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