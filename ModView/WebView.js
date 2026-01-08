const vscode = require('vscode');
const fs = require('fs');
const path = require('path');


/**
 * A class to manage the custom webview editor for specific files or views.
 */
class WebView {
    /**
     * @param {string} name - The name of the view to determine the HTML file to load.
     * @param {string} title - The title of the webview panel.
     * @param {string} viewType - The unique identifier for the webview panel.
     */
    constructor(name, title, viewType) {
        this.name = name;
        this.defaultTitle = title;
        this.viewType = viewType;
        this.panel = null;
        
        this.currentTitle = () => this.panel ? this.panel.title : this.defaultTitle;

        this.onOpen = () => { };
        this.onMessage = (type, data) => { };
        this.onClose = () => { };
    }

    setTitle(title) {
        if (this.panel) {
            this.panel.title = title || this.defaultTitle;
        }
    }

    /**
     * Opens the webview as a new panel.
     * @returns {boolean} True if the panel was created successfully, false otherwise.
     */
    open(context) {
        // If the panel is already open, reveal it
        if (this.panel) {
            this.panel.reveal(vscode.ViewColumn.One);
            return true;
        }
        // Create a new webview panel
        this.panel = vscode.window.createWebviewPanel(
            this.viewType,
            this.defaultTitle,
            vscode.ViewColumn.One,
            { enableScripts: true, retainContextWhenHidden: true } // Retain context to prevent content loss
        );

        const htmlContent = this.getHtmlForWebview(context, this.panel);
        this.panel.webview.html = htmlContent || '<h1>Error loading view</h1>';

        const previewImagePath = this.getPreviewImagePath(this.panel);
        this.panel.webview.postMessage({ type: 'initialize', previewImagePath });

        this.panel.webview.onDidReceiveMessage((e) => {
            const { type, data } = e;
            this.onMessage(type, data);
        });

        this.onOpen();

        this.panel.onDidDispose(() => {
            this.onClose();
            this.panel = null;
        });

        return this.panel ? true : false;
    }

    /**
     * Closes the webview panel if it is open.
     * @return {void}
     */
    close() {
        if (this.panel) {
            this.panel.dispose();
            this.panel = null;
        }
    }

    /**
     * Reloads the webview content.
     * @param {vscode.ExtensionContext} context - The extension context.
     * @returns {void}
     */
    reload(context) {
        if (this.panel)
            this.close();
        this.open(context);
    }

    /**
     * Sends a message to the webview.
     * @param {string} type - The type of the message.
     * @param {any} data - The data to send with the message.
     * @returns {boolean} True if the message was sent successfully, false otherwise.
     */

    send(type, data) {
        if (!this.panel) return false;
        this.panel.webview.postMessage(JSON.stringify({ type: type, data: data }));
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
     * @param {vscode.ExtensionContext} context - The extension context.
     * @param {vscode.WebviewPanel} webviewPanel - The webview panel to display the content.
     * @returns {string|null} The HTML content for the webview, or null if the file cannot be loaded.
     */
    getHtmlForWebview(context, webviewPanel) {
        const htmlPath = context.asAbsolutePath(`./ModView/${this.name}/index.html`);
        const webviewPath = context.asAbsolutePath(`./ModView/${this.name}`);
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