const vscode = require('vscode');
const fs = require('fs');
const path = require('path');


/**
 * A class to manage the custom webview editor for specific files or views.
 */
class WebView {
    /**
     * @param {vscode.ExtensionContext} context - The extension context.
     * @param {string} name - The name of the view to determine the HTML file to load.
     */
    constructor(context, name, title, viewType) {
        this.context = context;
        this.name = name;
        this.title = title;
        this.viewType = viewType;
        this.panel = null;
    }

    /**
     * Opens the webview as a new panel.
     * @returns {boolean} True if the panel was created successfully, false otherwise.
     */
    open() {
        this.panel = vscode.window.createWebviewPanel(
            this.viewType,
            this.title,
            vscode.ViewColumn.One,
            { enableScripts: true, retainContextWhenHidden: true } // Retain context to prevent content loss
        );

        const htmlContent = this.getHtmlForWebview(this.panel);
        this.panel.webview.html = htmlContent || '<h1>Error loading view</h1>';

        const previewImagePath = this.getPreviewImagePath(this.panel);
        this.panel.webview.postMessage({ type: 'initialize', previewImagePath });

        // Send the 'update' message after initialization
        const rootPath = vscode.workspace.workspaceFolders[0].uri.fsPath;
        const infoTxtPath = path.join(rootPath, 'info.txt');
        if (fs.existsSync(infoTxtPath)) {
            const infoTxtContent = fs.readFileSync(infoTxtPath, 'utf8');
            this.panel.webview.postMessage({
                type: 'update',
                text: infoTxtContent
            });
        }

        this.panel.webview.onDidReceiveMessage((e) => {
            if (e.type === 'save') {
                this.saveFile(e.filePath, e.content);
            } else if (e.type === 'selectIcon') {
                vscode.window.showOpenDialog({
                    canSelectMany: false,
                    openLabel: 'Select Icon',
                    filters: {
                        Images: ['png', 'jpg', 'jpeg']
                    }
                }).then(fileUri => {
                    if (fileUri && fileUri[0]) {
                        const selectedPath = fileUri[0].fsPath;
                        const rootPath = vscode.workspace.workspaceFolders[0].uri.fsPath;
                        const targetPath = path.join(rootPath, 'preview.jpg');

                        fs.copyFile(selectedPath, targetPath, (err) => {
                            if (err) {
                                vscode.window.showErrorMessage(`Failed to set new icon: ${err.message}`);
                            } else {
                                vscode.window.showInformationMessage('Icon updated successfully!');

                                // Dynamically update the icon in the webview
                                this.panel.webview.postMessage({
                                    type: 'updateIcon',
                                    previewImagePath: this.panel.webview.asWebviewUri(vscode.Uri.file(targetPath)).toString()
                                });
                            }
                        });
                    }
                });
            }
        });

        return this.panel ? true : false;
    }

    sendUpdate(type, data) {
        if (!this.panel) return false;
        this.panel.webview.postMessage({ type: type, data: data });
        return true;
    }

    /**
     * Resolves the preview image path.
     * @param {vscode.WebviewPanel} panel - The webview panel.
     * @returns {string} The URI of the preview image or an empty string if not found.
     */
    getPreviewImagePath(panel) {
        const rootPath = vscode.workspace.workspaceFolders[0].uri.fsPath;
        const previewFiles = ['preview.jpg', 'preview.png'];

        for (const file of previewFiles) {
            const filePath = path.join(rootPath, file);
            if (fs.existsSync(filePath)) {
                return panel.webview.asWebviewUri(vscode.Uri.file(filePath)).toString();
            }
        }
        return '';
    }

    /**
     * Saves content to a file.
     * @param {string} filePath - The path of the file to save.
     * @param {string} content - The content to save to the file.
     */
    saveFile(filePath, content) {
        fs.writeFile(filePath, content, (err) => {
            if (err) {
                vscode.window.showErrorMessage(`Failed to save file: ${err.message}`);
            } else {
                vscode.window.showInformationMessage(`File saved: ${filePath}`);
            }
        });
    }

    /**
     * Generates the HTML content for the webview.
     * @param {vscode.WebviewPanel} webviewPanel - The webview panel to display the content.
     * @returns {string|null} The HTML content for the webview, or null if the file cannot be loaded.
     */
    getHtmlForWebview(webviewPanel) {
        const htmlPath = this.context.asAbsolutePath(`./ModView/${this.name}/index.html`);
        const webviewPath = this.context.asAbsolutePath(`./ModView/${this.name}`);
        const webviewUri = this.getWebviewUri(webviewPath);

        try {
            let htmlContent = fs.readFileSync(htmlPath, 'utf8');
            htmlContent = htmlContent.replaceAll(`src="`, `src="${webviewUri}/`);
            htmlContent = htmlContent.replaceAll(`href="`, `href="${webviewUri}/`);
            // For debugging: write the final HTML to a log file
            //fs.writeFileSync(
            //    `C:\\Users\\gusta\\Desktop\\coding\\VSCode-Extensions\\Teardown-Modding\\logs\\debug_log.html`,
            //    htmlContent, 'utf8');

            return htmlContent;
        } catch (error) {
            console.error(`Failed to load HTML content from ${htmlPath}: ${error.message}`);
            return null;
        }
    }

    /**
     * Gets the webview URI for a given file path.
     * @param {string} filePath - The file path to convert.
     * @returns {string} The webview URI for the file.
     */
    getWebviewUri(filePath) {
        if (!this.panel) return null;
        return this.panel.webview.asWebviewUri(vscode.Uri.file(filePath));
    }
}

module.exports = WebView;