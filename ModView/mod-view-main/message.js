// Listen for messages from the extension
window.addEventListener('message', (event) => {
    const { type, data } = JSON.parse(event.data);

    switch (type) {
        case 'infoTxt':
            loadModInfo(data);
            break;
            
        case 'modIconPath':
            const iconElement = document.getElementById('mod-icon');
            if (iconElement) {
                iconElement.src = data;
            }
            break;
            
        case 'workspaceSettings':
            updateSettings(data);
            break;
            
        default:
            console.warn('Unknown message type received:', type);
            break;
    }
});