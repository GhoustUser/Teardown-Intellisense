import vscode from "vscode";
import path from "path";
import fs from "fs";

import WebView from "../../scripts/classes/web-view";
import VscManager from "../../scripts/classes/vsc-manager";
import { loadScriptingApi, isScriptingApiLoaded, unloadScriptingApi } from "../../scripts/load-lua-api";

function initializeModViewMain(modview: WebView, vscManager: VscManager): void {
    modview.onOpen(() => {
        // read and send info.txt content to webview
        const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
        if (fs.existsSync(infoTxtPath)) {
            const infoTxtContent = fs.readFileSync(infoTxtPath, "utf8");
            modview.send("infoTxt", infoTxtContent);
            console.log("\x1b[32mSent info.txt content to webview\x1b[0m");
        }

        // send mod icon path if it exists (try .png first, then .jpg)
        const iconExtensions = ["png", "jpg", "jpeg"];
        let iconFound = false;
        for (const iconExtension of iconExtensions) {
            const modIconPath = path.join(vscManager.projectPath, `preview.${iconExtension}`);
            if (fs.existsSync(modIconPath)) {
                const modIconUri = modview.getWebviewUri(modIconPath);
                modview.send("modIconPath", modIconUri.toString());
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
        modview.send("workspaceSettings", settings);

        console.log("\x1b[32mMod View opened\x1b[0m");
    });

    modview.onMessage(({ type, data }) => {
        switch (type) {
            case "reload":
                modview.reload(vscManager.context);
                modview.setTitle(modview.defaultTitle);
                console.log("\x1b[32mWebview reloaded\x1b[0m");
                break;

            case "unsavedChanges":
                //console.log(`\x1b[32mUnsaved changes: \x1b[96m${data}\x1b[0m`);
                const title = data ? `${modview.defaultTitle} (unsaved)` : modview.defaultTitle;
                modview.setTitle(title);
                break;

            case "saveModInfo":
                const infoTxtPath = path.join(vscManager.projectPath, "info.txt");
                fs.writeFileSync(infoTxtPath, data, "utf8");
                console.log(`\x1b[32mMod info saved to info.txt\x1b[0m`);
                vscode.window.showInformationMessage("Mod info saved successfully.");
                modview.setTitle(modview.defaultTitle);
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

    modview.onClose(() => {
        console.log("\x1b[33mMod View closed\x1b[0m");
    });
}

export default initializeModViewMain;