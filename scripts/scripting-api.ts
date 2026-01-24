import path from "path";
import VscManager from "./vsc-manager";

/** Enables or disables the Teardown Lua API in the VSCode Lua workspace configuration.
 * @param {boolean} enable - Whether to enable or disable the scripting API
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {void}
 */
function configureTDIntellisense(enable: boolean, vscManager: VscManager): void {

    const luaApiPath = path.join(vscManager.context.extensionPath, "api-definitions");
    const workspaceLibrary = vscManager.getSetting("Lua.workspace.library", [])
        // filter out any existing Teardown API paths
        .filter((libPath: string) => !libPath.toLowerCase().includes("teardown"));

    // add the new path and update setting
    const updatedLibrary = enable ?
        // add path if enabling
        [...workspaceLibrary, luaApiPath] :
        // just use the filtered array if disabling
        workspaceLibrary;
    // if updatedLibrary is empty, remove the setting completely
    if (updatedLibrary.length === 0)
        vscManager.updateSetting("Lua.workspace.library", undefined, false);
    // otherwise update the setting normally
    else
        vscManager.updateSetting("Lua.workspace.library", updatedLibrary, false);

    // if enabling, disable duplicate-set-field diagnostic
    const diagnostics = vscManager.getSetting("Lua.diagnostics.disable", []);
    if (enable && !diagnostics.includes("duplicate-set-field")) {
        vscManager.updateSetting("Lua.diagnostics.disable", [...diagnostics, "duplicate-set-field"], false);
    }
    // if disabling, re-enable duplicate-set-field diagnostic
    else if (!enable) {
        const filteredDiagnostics = diagnostics.filter((diagnostic: string) =>
            diagnostic !== "duplicate-set-field"
        );
        // if filteredDiagnostics is empty, remove the setting completely
        if (filteredDiagnostics.length === 0)
            vscManager.updateSetting("Lua.diagnostics.disable", undefined, false);
        // otherwise update the setting normally
        else
            vscManager.updateSetting("Lua.diagnostics.disable", filteredDiagnostics, false);
    }
}

export { configureTDIntellisense };
