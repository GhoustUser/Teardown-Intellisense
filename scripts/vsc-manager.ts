import vscode from "vscode";

type InfoMessageAction = {
    name: string;
    action: () => void;
}

class VscManager {
    private _context: vscode.ExtensionContext;
    private _workspaceFolders: readonly vscode.WorkspaceFolder[] | undefined;
    private _projectPath: string | null;

    /** Gets the extension context.
     * @returns {vscode.ExtensionContext} The extension context.
     */
    public get context(): vscode.ExtensionContext {
        return this._context;
    }
    /** Gets the workspace folders.
     * @returns {readonly vscode.WorkspaceFolder[]} The workspace folders.
     */
    public get workspaceFolders(): readonly vscode.WorkspaceFolder[] {
        return this._workspaceFolders || [];
    }
    /** Gets the project path.
     * @returns {string} The project path.
     */
    public get projectPath(): string {
        return this._projectPath || "";
    }

    public get workspaceUri(): vscode.Uri | null {
        if (this._hasWorkspaceFolder()) {
            return this._workspaceFolders![0]!.uri;
        }
        return null;
    }

    private _hasWorkspaceFolder(): boolean {
        return this._workspaceFolders !== undefined &&
            this._workspaceFolders.length > 0 &&
            this._workspaceFolders[0] !== undefined;
    }

    /** Creates an instance of VscManager.
     * @param {vscode.ExtensionContext} context - Extension context provided by VS Code
     */
    constructor(context: vscode.ExtensionContext) {
        this._context = context;
        this._workspaceFolders = vscode.workspace.workspaceFolders;
        this._projectPath = this.workspaceUri?.fsPath || null;
    }

    /** Retrieves a workspace or global setting value.
     * @param {string} settingKey - The key of the setting to retrieve.
     * @param {any} defaultValue - The default value to return if the setting is not found.
     * @returns {any} - The value of the setting or the default value.
     */
    public getSetting(
        settingKey: string,
        defaultValue: any
    ): any {
        // get workspace-specific configuration
        const config = vscode.workspace.getConfiguration("", this.workspaceUri);

        // try to get the workspace-level setting first
        const workspaceValue = config.inspect(settingKey)?.workspaceValue;
        if (workspaceValue !== undefined) {
            return workspaceValue;
        }

        // fall back to any configured value or default
        return config.get(settingKey, defaultValue);
    }

    /** Updates a workspace setting value.
     * @param {string} settingKey - The key of the setting to set.
     * @param {any} value - The value to set for the setting.
     * @param {boolean} isGlobal - Whether to set the setting globally or for the workspace.
     * @returns {Thenable<void>} - A promise that resolves when the setting is updated.
     */
    public updateSetting(
        settingKey: string,
        value: any,
        isGlobal: boolean
    ): Thenable<void> {
        // get workspace-specific configuration
        const config = vscode.workspace.getConfiguration("", this.workspaceUri);

        // update setting with proper scope (workspace-level by default)
        const target = isGlobal ? vscode.ConfigurationTarget.Global : vscode.ConfigurationTarget.Workspace;
        return config.update(settingKey, value, target);
    }

    /** Registers a listener for changes to a specific workspace setting.
     * @param {string} settingKey - The key of the setting to listen for changes
     * @param {function} callback - Callback function to execute when the setting changes
     * @returns {vscode.Disposable} - A disposable to unregister the listener.
     */
    public onWorkspaceSettingChanged(
        settingKey: string,
        callback: (newValue: any) => void
    ): vscode.Disposable {
        // get workspace-specific configuration
        const workspaceUri = this.workspaceUri || undefined;
        // if no workspace was found, cancel
        if (!workspaceUri) {
            return new vscode.Disposable(() => { });
        }
        // create and return listener for workspace settings
        return vscode.workspace.onDidChangeConfiguration(event => {
            // check if the changed setting affects the specified key
            if (event.affectsConfiguration(settingKey, workspaceUri)) {
                const config = vscode.workspace.getConfiguration("", workspaceUri);
                const newValue = config.get(settingKey);
                // invoke the callback with the new value
                callback(newValue);
            }
        });
    }

    /** Registers a listener for changes to a specific user setting.
     * @param {string} settingKey - The key of the setting to listen for changes
     * @param {function} callback - Callback function to execute when the setting changes
     * @returns {vscode.Disposable} - A disposable to unregister the listener.
     */
    public onUserSettingChanged(
        settingKey: string,
        callback: (newValue: any) => void
    ): vscode.Disposable {
        // create and return listener for global/user settings
        return vscode.workspace.onDidChangeConfiguration(event => {
            // check if the changed setting affects the specified key at global level
            if (event.affectsConfiguration(settingKey)) {
                const config = vscode.workspace.getConfiguration();
                const newValue = config.inspect(settingKey)?.globalValue;
                // invoke the callback with the new value
                callback(newValue);
            }
        });
    }

    /** Registers a listener for changes to a specific setting (workspace or user).
     * @param {string} settingKey - The key of the setting to listen for changes
     * @param {function} callback - Callback function to execute when the setting changes
     * @returns {vscode.Disposable} - A disposable to unregister the listener.
     */
    public onSettingChanged(
        settingKey: string,
        callback: (newValue: any) => void
    ): vscode.Disposable {
        // create and return listener for both workspace and user settings
        return vscode.workspace.onDidChangeConfiguration(event => {
            // check if the changed setting affects the specified key
            if (event.affectsConfiguration(settingKey)) {
                const config = vscode.workspace.getConfiguration("", this.workspaceUri);
                const newValue = config.get(settingKey);
                // invoke the callback with the new value
                callback(newValue);
            }
        });
    }

    /** Registers a command in VS Code.
     * @param {string} command - The command identifier.
     * @param {() => void} callback - The function to execute when the command is invoked.
     * @returns {void}
     */
    public registerCommand(
        command: string,
        callback: () => void
    ): void {
        const disposable = vscode.commands.registerCommand(command, callback);
        this._context.subscriptions.push(disposable);
    }

    /** Shows an information message to the user.
     * @param {string} message - The message to display.
     * @param {InfoMessageAction[]} actions - The actions to display as buttons.
     * @returns {Promise<InfoMessageAction|undefined>} - A promise that resolves to the selected action, or undefined.
     * @example
     * vscManager.showInformationMessage("Here's a message", [
     *     { name: "Here's an action", action: () => console.log("Action executed!") },
     *     { name: "Here's another action", action: () => console.log("Another action executed!") }
     * ]);
     */
    public async showInformationMessage(
        message: string,
        actions: InfoMessageAction[]
    ): Promise<InfoMessageAction | undefined> {
        // show the information message with action buttons and wait for user selection
        const selection = await vscode.window.showInformationMessage(
            message,
            ...actions.map(action => action.name)
        );
        // find the action corresponding to the selected button
        const action_1 = actions.find(act => act.name === selection);
        // if an action was selected, execute its function
        if (action_1) {
            action_1.action();
        }
        return action_1;
    }

    /** Opens the user settings UI in VS Code.
     * @param {string} [args] - Optional arguments to pass to the settings UI.
     * @returns {void}
     */
    public openUserSettingsUI(args?: string): void {
        if (args) {
            vscode.commands.executeCommand("workbench.action.openSettings", args);
        } else {
            vscode.commands.executeCommand("workbench.action.openSettings");
        }
    }

    /** Opens the workspace settings UI in VS Code.
     * @param {string} [args] - Optional arguments to pass to the settings UI.
     * @returns {void}
     */
    public openWorkspaceSettingsUI(args?: string): void {
        if (args) {
            vscode.commands.executeCommand("workbench.action.openWorkspaceSettings", args);
        } else {
            vscode.commands.executeCommand("workbench.action.openWorkspaceSettings");
        }
    }
}

export default VscManager;
