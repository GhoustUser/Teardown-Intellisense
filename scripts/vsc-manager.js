const vscode = require("vscode");


class VscManager {
    /**
     * Creates an instance of VscManager.
     * @param {vscode.ExtensionContext} context - Extension context provided by VS Code
     */
    constructor(context) {
        this.context = context;
        this.workspaceFolders = vscode.workspace.workspaceFolders;
        this.workspaceSettings = vscode.workspace.getConfiguration("", null);

        this.projectPath = this.workspaceFolders
            ? this.workspaceFolders[0].uri.fsPath
            : null;
    }

    /**
     * Retrieves a workspace setting value.
     * @param {string} settingKey - The key of the setting to retrieve.
     * @param {any} defaultValue - The default value to return if the setting is not found.
     * @returns {any} - The value of the setting or the default value.
     */
    getSetting(settingKey, defaultValue) {
        return this.workspaceSettings.get(settingKey, defaultValue);
    }

    /**
     * Registers a command in VS Code.
     * @param {string} command - The command identifier.
     * @param {()=>void} callback - The function to execute when the command is invoked.
     */
    registerCommand(command, callback) {
        const disposable = vscode.commands.registerCommand(command, callback);
        this.context.subscriptions.push(disposable);
    }

    /**
     * Shows an information message to the user.
     * @param {string} message - The message to display.
     * @param {{name:string, action:()=>void}[]} actions - The actions to display as buttons.
     * @returns {*} A promise that resolves to the selected action.
     * @example
     * vscManager.showInformationMessage("Here's a message", [
     *     { name: "Here's an action", action: () => console.log("Action executed!") },
     *     { name: "Here's another action", action: () => console.log("Another action executed!") }
     * ]);
     */
    showInformationMessage(message, actions) {
        return vscode.window.showInformationMessage(
            message,
            ...actions.map(action => action.name)
        ).then(selection => {
            const action = actions.find(act => act.name === selection);
            if (action) {
                action.action();
            }
            return action;
        });
    }
}

module.exports = VscManager;