const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const { IsScriptingApiLoaded, LoadScriptingApi } = require("./scripts/load-lua-api.js");
const { LoadModData } = require("./scripts/load-mod-data.js");
const WebView = require("./ModView/WebView.js");


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

    // Check if Mod View is already open
    const existingPanel = vscode.window.visibleTextEditors.find(editor => editor.document.fileName.includes("main-mod-view"));
    if (!existingPanel) {
        // Prompt user to open the Mod View
        console.log("Prompting user to load Teardown Modding Extension...");

        vscode.window.showInformationMessage(
            "Teardown Mod detected in workspace.",
            "Open Mod View"
        ).then(selection => {
            // handle user selection
            switch (selection) {
                case "Open Mod View":
                    openModView(context);
                    break;
                case null:
                    return; // user dismissed the prompt
            }
        });
    }

    if (!moddingEnabled) return;

    // Proceed with loading mod data and registering commands
    LoadModData(context, rootPath);
    registerCommands(context)
    // Load the Lua API into the workspace configuration if not already loaded
    if (!IsScriptingApiLoaded(context)) {
        LoadScriptingApi(context);
    }

    // Open Mod View by default if the setting is enabled
    const openModViewByDefault = workspaceSettings.get("TeardownModding.OpenModViewByDefault", false);
    if (openModViewByDefault) {
        openModView(context);
    }
}

/**
 * Opens the main Mod View webview.
 * @param {vscode.ExtensionContext} context - The extension context.
 */
function openModView(context) {
    const modView = new WebView(
        context,
        "main",
        (html, filePath, fileContent) => html
    );

    const panel = modView.open("Teardown Mod View", "main-mod-view");

    if (!panel) {
        console.error("Failed to create webview panel.");
        return;
    }

    // Read the contents of info.txt and send it to the webview
    const rootPath = workspaceFolders[0].uri.fsPath;
    const infoTxtPath = path.join(rootPath, "info.txt");
    if (fs.existsSync(infoTxtPath)) {
        const infoTxtContent = fs.readFileSync(infoTxtPath, "utf8");
        panel.webview.postMessage({
            type: "update",
            text: infoTxtContent
        });
    }
}

/**
 * Parses the content of info.txt into fields.
 * @param {string} content - The content of the info.txt file.
 * @returns {Object} An object containing the parsed fields.
 */
function parseInfoTxt(content) {
    const lines = content.split('\n');
    const fields = { name: '', author: '', description: '', tags: '', version: '' };
    let currentField = null;

    lines.forEach(line => {
        if (line.startsWith('name = ')) {
            fields.name = line.replace('name = ', '').trim();
        } else if (line.startsWith('author = ')) {
            fields.author = line.replace('author = ', '').trim();
        } else if (line.startsWith('description = ')) {
            fields.description = line.replace('description = ', '').trim();
            currentField = 'description';
        } else if (line.startsWith('tags = ')) {
            fields.tags = line.replace('tags = ', '').trim();
            currentField = null;
        } else if (line.startsWith('version = ')) {
            fields.version = line.replace('version = ', '').trim();
            currentField = null;
        } else if (currentField === 'description') {
            fields.description += '\n' + line.trim();
        }
    });

    return fields;
}

/**
 * Registers commands for the extension.
 * @param {vscode.ExtensionContext} context - The extension context.
 */
function registerCommands(context) {
    context.subscriptions.push(
        vscode.commands.registerCommand("teardownModding.openModView", () => {
            openModView(context);
        })
    );
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