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
    public get workspaceFolders(): readonly vscode.WorkspaceFolder[]{
        return this._workspaceFolders || [];
    }
    /** Gets the project path.
     * @returns {string} The project path.
     */
    public get projectPath(): string {
        return this._projectPath || "";
    }

    private _hasWorkspaceFolder(): boolean {
        return this._workspaceFolders !== undefined && this._workspaceFolders.length > 0 && this._workspaceFolders[0] !== undefined;
    }

    /** Creates an instance of VscManager.
     * @param {vscode.ExtensionContext} context - Extension context provided by VS Code
     */
    constructor(context: vscode.ExtensionContext) {
        this._context = context;
        this._workspaceFolders = vscode.workspace.workspaceFolders;

        if (this._workspaceFolders && this._workspaceFolders.length > 0 && this._workspaceFolders[0])
            this._projectPath = this._workspaceFolders[0].uri.fsPath;
        else
            this._projectPath = null;
    }

    /** Retrieves a workspace setting value.
     * @param {string} settingKey - The key of the setting to retrieve.
     * @param {any} defaultValue - The default value to return if the setting is not found.
     * @returns {any} - The value of the setting or the default value.
     */
    getSetting(settingKey: string, defaultValue: any): any {
        // Get workspace-specific configuration
        const workspaceUri = this._hasWorkspaceFolder() ? this._workspaceFolders![0]!.uri : undefined;
        const config = vscode.workspace.getConfiguration("", workspaceUri);
        
        // Try to get the workspace-level setting first
        const workspaceValue = config.inspect(settingKey)?.workspaceValue;
        if (workspaceValue !== undefined) {
            return workspaceValue;
        }
        
        // Fall back to any configured value or default
        return config.get(settingKey, defaultValue);
    }

    /** Updates a workspace setting value.
     * @param {string} settingKey - The key of the setting to set.
     * @param {any} value - The value to set for the setting.
     * @param {boolean} [isGlobal=false] - Whether to set the setting globally or for the workspace.
     * @returns {Thenable<void>} - A promise that resolves when the setting is updated.
     */
    updateSetting(settingKey: string, value: any, isGlobal: boolean = false): Thenable<void> {
        // Get workspace-specific configuration
        const workspaceUri = this._hasWorkspaceFolder() ? this._workspaceFolders![0]!.uri : undefined;
        const config = vscode.workspace.getConfiguration("", workspaceUri);
        
        // Update setting with proper scope (workspace-level by default)
        const target = isGlobal ? vscode.ConfigurationTarget.Global : vscode.ConfigurationTarget.Workspace;
        return config.update(settingKey, value, target);
    }

    /** Registers a command in VS Code.
     * @param {string} command - The command identifier.
     * @param {() => void} callback - The function to execute when the command is invoked.
     * @returns {void}
     */
    registerCommand(command: string, callback: () => void): void {
        const disposable = vscode.commands.registerCommand(command, callback);
        this._context.subscriptions.push(disposable);
    }

    /** Shows an information message to the user.
     * @param {string} message - The message to display.
     * @param {InfoMessageAction[]} actions - The actions to display as buttons.
     * @returns {Promise<InfoMessageAction|undefined>} - The action selected by the user, or undefined if none was selected.
     * @example
     * vscManager.showInformationMessage("Here's a message", [
     *     { name: "Here's an action", action: () => console.log("Action executed!") },
     *     { name: "Here's another action", action: () => console.log("Another action executed!") }
     * ]);
     */
    async showInformationMessage(
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
}

export default VscManager;