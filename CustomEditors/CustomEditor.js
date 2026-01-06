const vscode = require('vscode');
const fs = require('fs');


/**
 * A class to manage the custom webview editor for specific files.
 */
class CustomEditor {
    /**
     * @param {vscode.ExtensionContext} context - The extension context.
     * @param {string} fileName - The name of the file to determine the HTML file to load.
     * @param {function(html: string, filePath: string, fileContent: string): string} htmlProcessor - A function to process the HTML content before displaying.
     */
    constructor(context, fileName, htmlProcessor = (html, filePath, fileContent) => html) {
        this.context = context;
        this.fileName = fileName;
        this.htmlProcessor = htmlProcessor;
    }

    /**
     * Registers the custom editor provider with VS Code.
     * @param {string} viewType - The unique identifier for the custom editor.
     */
    register(viewType) {
        this.context.subscriptions.push(
            vscode.window.registerCustomEditorProvider(
                viewType,
                this,
                {
                    supportsMultipleEditorsPerDocument: false
                }
            )
        );
    }

    /**
     * Resolves the custom text editor by setting up the webview content and event listeners.
     * @param {vscode.TextDocument} document - The document to be displayed in the webview.
     * @param {vscode.WebviewPanel} webviewPanel - The webview panel to display the content.
     * @param {vscode.CancellationToken} _token - A cancellation token.
     */
    resolveCustomTextEditor(document, webviewPanel, _token) {
        webviewPanel.webview.options = {
            enableScripts: true
        };

        const htmlContent = this.getHtmlForWebview(document, webviewPanel);
        if (htmlContent) {
            webviewPanel.webview.html = htmlContent;
        } else {
            webviewPanel.webview.html = '<h1>Error loading editor</h1>';
        }

        const updateWebview = () => {
            webviewPanel.webview.postMessage({
                type: 'update',
                text: document.getText()
            });
        };

        const changeDocumentSubscription = vscode.workspace.onDidChangeTextDocument(e => {
            if (e.document.uri.toString() === document.uri.toString()) {
                updateWebview();
            }
        });

        // Update webview when the panel becomes active
        webviewPanel.onDidChangeViewState(e => {
            if (webviewPanel.visible) {
                updateWebview();
            }
        });

        webviewPanel.onDidDispose(() => {
            changeDocumentSubscription.dispose();
        });

        webviewPanel.webview.onDidReceiveMessage(e => {
            switch (e.type) {
                case 'edit':
                    this.updateTextDocument(document, e.text);
                    return;
            }
        });

        updateWebview();
    }

    /**
     * Updates the text document with new content.
     * @param {vscode.TextDocument} document - The document to update.
     * @param {string} text - The new content for the document.
     */
    updateTextDocument(document, text) {
        const edit = new vscode.WorkspaceEdit();
        edit.replace(
            document.uri,
            new vscode.Range(0, 0, document.lineCount, 0),
            text
        );
        return vscode.workspace.applyEdit(edit);
    }

    /**
     * Generates the HTML content for the webview.
     * @param {vscode.TextDocument} document - The document to display in the webview.
     * @param {vscode.WebviewPanel} webviewPanel - The webview panel to display the content.
     * @returns {string|null} The HTML content for the webview, or null if the file cannot be loaded.
     */
    getHtmlForWebview(document, webviewPanel) {
        const htmlPath = this.context.asAbsolutePath(`./CustomEditors/${this.fileName.replace('.', '_')}/index.html`);
        const cssPath = this.context.asAbsolutePath(`./CustomEditors/${this.fileName.replace('.', '_')}/style.css`);
        try {
            let htmlContent = fs.readFileSync(htmlPath, 'utf8');
            const cssUri = webviewPanel.webview.asWebviewUri(vscode.Uri.file(cssPath));
            const nonce = this.getNonce();

            htmlContent = htmlContent.replace('<link rel="stylesheet" href="style.css">', `<link rel="stylesheet" href="${cssUri}">`);
            htmlContent = this.htmlProcessor(htmlContent, document.uri.fsPath, document.getText());
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

module.exports = CustomEditor;