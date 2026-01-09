// Listen for messages from the extension
window.addEventListener('message', (event) => {
    const { type, data } = JSON.parse(event.data);

    switch (type) {
        case 'infoTxt':
            loadModInfo(data);
            break;
        case 'modIconPath':
            document.getElementById('mod-icon').src = data;
            break;
    }
});