import path from "path";
import fs from "fs";
import VscManager from "./vsc-manager";

/** enables or disables intellisense
 * @param {boolean} enable - True to enable intellisense, false to disable
 * @param {VscManager} vscManager - The VscManager instance
 * @returns {boolean} True if operation was successful, false otherwise
*/
function configureTDIntellisense(enable: boolean, vscManager: VscManager): boolean {
    console.log(`${enable ? "Enabling" : "Disabling"} Teardown intellisense...`);
    const luarcPath = path.join(vscManager.projectPath, ".luarc.json");
    const gameDirectory: string = vscManager.getSetting("TeardownIntellisense.teardownDirectory", "");
    console.log(`Using Teardown directory:\x1b[32m ${gameDirectory}\x1b[0m`);

    // if no game directory is set, cannot configure
    if (gameDirectory === "") return false;

    const scriptDefsPath = path.join(gameDirectory, "data", "script_defs.lua");
    const voxscriptDefsPath = path.join(gameDirectory, "data", "voxscript_defs.lua");

    // read existing .luarc.json or create new one
    let luarcJson: any = fs.existsSync(luarcPath) ?
        JSON.parse(fs.readFileSync(luarcPath, "utf-8")) : {};

    // enable intellisense
    if (enable) {
        // set required fields
        luarcJson["runtime.version"] = "Lua 5.1";
        luarcJson["runtime.plugin"] = path.join(gameDirectory, "data", "td_vscode_plugin.lua");
        // ensure workspace.library is an array
        if (!Array.isArray(luarcJson["workspace.library"])) {
            luarcJson["workspace.library"] = [];
        }
        // filter out any existing Teardown paths to avoid duplicates
        luarcJson["workspace.library"] = luarcJson["workspace.library"].filter(
            (p: string) => !p.includes("script_defs") && !p.includes("voxscript_defs")
        );
        // add required paths if not already present
        if (!luarcJson["workspace.library"].includes(scriptDefsPath)) {
            luarcJson["workspace.library"].push(scriptDefsPath);
        }
        if (!luarcJson["workspace.library"].includes(voxscriptDefsPath)) {
            luarcJson["workspace.library"].push(voxscriptDefsPath);
        }
        // disable diagnostic "duplicate-set-field" warnings
        luarcJson["diagnostics.disable"] = luarcJson["diagnostics.disable"] || [];
        if (!luarcJson["diagnostics.disable"].includes("duplicate-set-field")) {
            luarcJson["diagnostics.disable"].push("duplicate-set-field");
        }
    }
    // disable intellisense
    else {
        // remove fields
        delete luarcJson["runtime.plugin"];
        if (Array.isArray(luarcJson["workspace.library"])) {
            // filter out the Teardown paths
            luarcJson["workspace.library"] = luarcJson["workspace.library"].filter(
                (p: string) => p !== scriptDefsPath && p !== voxscriptDefsPath
            );
            // if workspace.library is now empty, remove it
            if (luarcJson["workspace.library"].length === 0) {
                delete luarcJson["workspace.library"];
            }
        }
        // re-enable diagnostic "duplicate-set-field" warnings
        if (luarcJson["diagnostics"] && Array.isArray(luarcJson["diagnostics"]["disable"])) {
            luarcJson["diagnostics"]["disable"] = luarcJson["diagnostics"]["disable"].filter(
                (d: string) => d !== "duplicate-set-field"
            );
            if (luarcJson["diagnostics"]["disable"].length === 0) {
                delete luarcJson["diagnostics"]["disable"];
            }
            if (Object.keys(luarcJson["diagnostics"]).length === 0) {
                delete luarcJson["diagnostics"];
            }
        }
    }
    // get the user's preferred indentation setting
    const indentation = vscManager.getSetting("editor.tabSize", 4);
    // write updated .luarc.json
    fs.writeFileSync(luarcPath, JSON.stringify(luarcJson, null, indentation), "utf-8");
    return true;
}

export { configureTDIntellisense };
