const vscode = require("vscode");
const path = require("path");

/**
 * Loads the Teardown Lua API into the VSCode Lua workspace configuration.
 * @param {*} context 
 */
function LoadScriptingApi(context) {
    // Construct the path to the Lua API directory within the extension
    const luaApiPath = path.join(context.extensionPath, "teardown-lua-api");

    // Access the Lua configuration
    const luaConfig = vscode.workspace.getConfiguration("Lua");
    // Get existing library paths
    const existing = luaConfig.get("workspace.library") || [];

    // Add the Lua API path if not already present
    if (!existing.includes(luaApiPath)) {
        luaConfig.update(
            "workspace.library",
            [...existing, luaApiPath],
            vscode.ConfigurationTarget.Workspace
        );
    }
}

module.exports = {
    LoadScriptingApi
};