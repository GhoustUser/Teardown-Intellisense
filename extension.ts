import vscode from "vscode";
import path from "path";
import fs from "fs";
import WebView from "./scripts/classes/web-view";
import VscManager from "./scripts/classes/vsc-manager";
import { loadScriptingApi, isScriptingApiLoaded, unloadScriptingApi } from "./scripts/load-lua-api";

// initialize mod views
const modviews: { main: WebView } = {
    main: new WebView("mod-view-main", "Mod View")
}

/** Entry point for the extension.
 * @param {vscode.ExtensionContext} context - The extension context provided by VS Code
 * @returns {void}
 */

function activate(context: vscode.ExtensionContext): void {
    const vscManager = new VscManager(context);

    // check if there are workspace folders open
    if (!vscManager.workspaceFolders) {
        console.log("\x1b[33mNo workspace folders found\x1b[0m");
        return;
    }

    // if info.txt doesn't exist, exit early
    if (!fs.existsSync(path.join(vscManager.projectPath, "info.txt"))) {
        console.log("\x1b[33mNo Teardown mod detected in workspace\x1b[0m");
        return;
    }

    console.log(`\x1b[32mTeardown mod detected at: \x1b[96m${vscManager.projectPath}\x1b[0m`);

    modviews.main.onOpen(() => {
        // read and send info.txt content to webview
        const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
        if (fs.existsSync(infoTxtPath)) {
            const infoTxtContent = fs.readFileSync(infoTxtPath, "utf8");
            modviews.main.send("infoTxt", infoTxtContent);
            console.log("\x1b[32mSent info.txt content to webview\x1b[0m");
        }

        // send mod icon path if it exists (try .png first, then .jpg)
        const iconExtensions = ["png", "jpg", "jpeg"];
        let iconFound = false;
        for (const iconExtension of iconExtensions) {
            const modIconPath = path.join(vscManager.projectPath, `preview.${iconExtension}`);
            if (fs.existsSync(modIconPath)) {
                const modIconUri = modviews.main.getWebviewUri(modIconPath);
                modviews.main.send("modIconPath", modIconUri.toString());
                console.log(`\x1b[32mFound mod icon: \x1b[96m${iconExtension}\x1b[0m`);
                iconFound = true;
                break;
            }
        }
        if (!iconFound) {
            console.log("\x1b[33mNo mod icon found (preview.png or preview.jpg)\x1b[0m");
        }

        // send workspace settings to webview
        const settings = {
            openByDefault: vscManager.getSetting("teardownModding.openModViewByDefault", false),
            enableScriptingApi: isScriptingApiLoaded(vscManager)
        };
        modviews.main.send("workspaceSettings", settings);

        console.log("\x1b[32mMod View opened\x1b[0m");
    });

    modviews.main.onMessage(({ type, data }) => {
        switch (type) {
            case "reload":
                modviews.main.reload(context);
                modviews.main.setTitle(modviews.main.defaultTitle);
                console.log("\x1b[32mWebview reloaded\x1b[0m");
                break;
                
            case "unsavedChanges":
                //console.log(`\x1b[32mUnsaved changes: \x1b[96m${data}\x1b[0m`);
                const title = data ? `${modviews.main.defaultTitle} (unsaved)` : modviews.main.defaultTitle;
                modviews.main.setTitle(title);
                break;
                
            case "saveModInfo":
                const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
                fs.writeFileSync(infoTxtPath, data, "utf8");
                console.log(`\x1b[32mMod info saved to info.txt\x1b[0m`);
                vscode.window.showInformationMessage("Mod info saved successfully.");
                modviews.main.setTitle(modviews.main.defaultTitle);
                break;
                
            case "setting_openByDefault":
                vscManager.updateSetting("teardownModding.openModViewByDefault", data);
                //console.log(`\x1b[32mSetting 'openModViewByDefault' updated to: \x1b[96m${data}\x1b[0m`);
                break;
                
            case "setting_enableScriptingApi":
                if (data) {
                    loadScriptingApi(vscManager);
                } else {
                    unloadScriptingApi(vscManager);
                }
                //console.log(`\x1b[32mScripting API ${data ? 'enabled' : 'disabled'}\x1b[0m`);
                break;
                
            default:
                console.warn(`\x1b[93mUnhandled message type: \x1b[35m${type}\x1b[93m with data: \x1b[96m${data}\x1b[0m`);
                break;
        }
    });

    modviews.main.onClose(() => {
        console.log("\x1b[33mMod View closed\x1b[0m");
    });

    // register command to open the Mod View
    vscManager.registerCommand("teardownModding.openModView", () => {
        modviews.main.open(context);
    });

    // open Mod View by default if the setting is enabled
    const shouldOpenByDefault = vscManager.getSetting("teardownModding.openModViewByDefault", false);
    if (shouldOpenByDefault) {
        modviews.main.open(context);
        console.log("\x1b[32mOpened Mod View by default (setting enabled)\x1b[0m");
    } else {
        vscManager.showInformationMessage(
            "Teardown Mod detected in workspace.",
            [{ name: "Open Mod View", action: () => modviews.main.open(context) }]
        );
    }
}

/** Cleanup function called when the extension is deactivated.
 * @returns {void}
 */
function deactivate(): void {}

module.exports = {
    activate,
    deactivate
};