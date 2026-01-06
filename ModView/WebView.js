const vscode = require('vscode');
const fs = require('fs');


/**
 * A class to manage the custom webview editor for specific files or views.
 */
class WebView {
    /**
     * @param {vscode.ExtensionContext} context - The extension context.
     * @param {string} viewName - The name of the view to determine the HTML file to load.
     * @param {function(html: string, filePath: string, fileContent: string): string} htmlProcessor - A function to process the HTML content before displaying.
     */
    constructor(context, viewName, htmlProcessor = (html, filePath, fileContent) => html) {
        this.context = context;
        this.viewName = viewName;
        this.htmlProcessor = htmlProcessor;
    }

    /**
     * Opens the webview as a new panel.
     * @param {string} title - The title of the webview panel.
     * @param {string} viewType - The unique identifier for the webview.
     */
    open(title, viewType) {
        const panel = vscode.window.createWebviewPanel(
            viewType,
            title,
            vscode.ViewColumn.One,
            { enableScripts: true }
        );

        const htmlContent = this.getHtmlForWebview(panel);
        if (htmlContent) {
            panel.webview.html = htmlContent;
        } else {
            panel.webview.html = '<h1>Error loading view</h1>';
        }

        panel.webview.onDidReceiveMessage(e => {
            switch (e.type) {
                case 'save':
                    this.saveFile(e.filePath, e.content);
                    return;
            }
        });

        return panel; // Ensure the panel is returned to the caller
    }

    /**
     * Saves content to a file.
     * @param {string} filePath - The path of the file to save.
     * @param {string} content - The content to save to the file.
     */
    saveFile(filePath, content) {
        fs.writeFile(filePath, content, err => {
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
        const htmlPath = this.context.asAbsolutePath(`./ModView/${this.viewName}/index.html`);
        const cssPath = this.context.asAbsolutePath(`./ModView/${this.viewName}/style.css`);
        try {
            let htmlContent = fs.readFileSync(htmlPath, 'utf8');
            const cssUri = webviewPanel.webview.asWebviewUri(vscode.Uri.file(cssPath));
            const nonce = this.getNonce();

            htmlContent = htmlContent.replace('<link rel="stylesheet" href="style.css">', `<link rel="stylesheet" href="${cssUri}">`);
            htmlContent = this.htmlProcessor(htmlContent, null, null);
            htmlContent = htmlContent.replace(/<Nonce>/g, nonce);
            return htmlContent;
        } catch (error) {
            console.error(`Failed to load HTML content from ${htmlPath}: ${error.message}`);
            return null;
        }
    }

    /**
     * Generates a nonce for securing the webview content.
     * @returns {string} A random nonce string.
     */
    getNonce() {
        let text = '';
        const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        for (let i = 0; i < 32; i++) {
            text += possible.charAt(Math.floor(Math.random() * possible.length));
        }
        return text;
    }
}

module.exports = WebView;