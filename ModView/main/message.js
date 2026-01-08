const vscode = acquireVsCodeApi();

// Listen for messages from the extension
window.addEventListener('message', (event) => {
    const message = event.data;
    const { type, data } = message;
    document.getElementById('mod-title').value = type;

    switch (type) {
        case 'infoTxt':
            document.getElementById('mod-description').value = data;
            break;
        case 'modIconPath':
            document.getElementById('mod-icon').src = data;
            break;
    }
});