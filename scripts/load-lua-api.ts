import path from "path";
import VscManager from "./classes/vsc-manager";

/** Checks if the Teardown Lua API is already loaded in the VSCode Lua workspace configuration.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {boolean} True if the Lua API is loaded, false otherwise
 */
function isScriptingApiLoaded(vscManager: VscManager): boolean {
    const luaApiPath = path.join(vscManager.context.extensionPath, "teardown-lua-api");
    const workspaceLibrary = vscManager.getSetting("Lua.workspace.library", []);
    console.log(`\x1b[34mCurrent Lua.workspace.library: \x1b[0m${JSON.stringify(workspaceLibrary)}`);
    return workspaceLibrary.includes(luaApiPath);
}

/** Loads the Teardown Lua API into the VSCode Lua workspace configuration.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function loadScriptingApi(vscManager: VscManager): void {
    if (isScriptingApiLoaded(vscManager)) {
        console.log("\x1b[33mTeardown Lua API already loaded\x1b[0m");
        return;
    }

    const luaApiPath = path.join(vscManager.context.extensionPath, "teardown-lua-api");
    const workspaceLibrary = vscManager.getSetting("Lua.workspace.library", []);
    
    // filter out any old teardown-lua-api paths from previous versions
    const filteredLibrary = workspaceLibrary.filter((libPath: string) => 
        !libPath.endsWith("teardown-lua-api")
    );

    // add the new path and update setting
    const updatedLibrary = [...filteredLibrary, luaApiPath];
    vscManager.updateSetting("Lua.workspace.library", updatedLibrary);
    
    // also disable duplicate-set-field diagnostic (Teardown API has intentional duplicates)
    const diagnostics = vscManager.getSetting("Lua.diagnostics.disable", []);
    if (!diagnostics.includes("duplicate-set-field")) {
        vscManager.updateSetting("Lua.diagnostics.disable", [...diagnostics, "duplicate-set-field"]);
    }

    console.log(`\x1b[32mTeardown Lua API loaded into workspace: \x1b[96m${luaApiPath}\x1b[0m`);
}

/** Unloads the Teardown Lua API from the VSCode Lua workspace configuration.
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function unloadScriptingApi(vscManager: VscManager): void {
    if (!isScriptingApiLoaded(vscManager)) {
        console.log("\x1b[33mTeardown Lua API is already unloaded\x1b[0m");
        return;
    }

    const luaApiPath = path.join(vscManager.context.extensionPath, "teardown-lua-api");
    const workspaceLibrary = vscManager.getSetting("Lua.workspace.library", []);
    
    // filter out teardown-lua-api paths
    const filteredLibrary = workspaceLibrary.filter((libPath: string) => 
        !libPath.endsWith("teardown-lua-api")
    );

    vscManager.updateSetting("Lua.workspace.library", filteredLibrary);
    
    // re-enable duplicate-set-field diagnostic
    const diagnostics = vscManager.getSetting("Lua.diagnostics.disable", []);
    const filteredDiagnostics = diagnostics.filter((diagnostic: string) => 
        diagnostic !== "duplicate-set-field"
    );
    vscManager.updateSetting("Lua.diagnostics.disable", filteredDiagnostics);

    console.log(`\x1b[32mTeardown Lua API unloaded from workspace\x1b[0m`);
}

export { isScriptingApiLoaded, loadScriptingApi, unloadScriptingApi };