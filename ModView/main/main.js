const vscode = acquireVsCodeApi();

// Function to parse the content into fields
function parseContent(content) {
    const lines = content.split('\n');
    const fields = { name: '', description: '', tags: '', version: '', iconPath: '' };
    let currentField = null;

    lines.forEach(line => {
        if (line.startsWith('name = ')) {
            fields.name = line.replace('name = ', '').trim();
        } else if (line.startsWith('description = ')) {
            fields.description = line.replace('description = ', '').trim();
            currentField = 'description';
        } else if (line.startsWith('tags = ')) {
            fields.tags = line.replace('tags = ', '').trim();
            currentField = null;
        } else if (line.startsWith('version = ')) {
            fields.version = line.replace('version = ', '').trim();
            currentField = null;
        } else if (line.startsWith('iconPath = ')) {
            fields.iconPath = line.replace('iconPath = ', '').trim();
        } else if (currentField === 'description') {
            fields.description += '\n' + line.trim();
        }
    });

    return fields;
}

// Handle the save button click
document.getElementById('saveButton').addEventListener('click', () => {
    const fields = {
        name: document.getElementById('mod-title').value,
        description: document.getElementById('mod-description').value,
        tags: document.getElementById('tags_field').value,
        version: document.getElementById('version_field').value
    };

    const saveString = mergeContent(fields);

    vscode.postMessage({
        type: 'edit',
        text: saveString
    });
});

// Function to merge fields into content
function mergeContent(fields) {
    let content = '';
    if (fields.name) content += `name = ${fields.name}\n`;
    if (fields.description) content += `description = ${fields.description}\n`;
    if (fields.tags) content += `tags = ${fields.tags}\n`;
    if (fields.version) content += `version = ${fields.version}\n`;
    return content.trim();
}

// Handle clicking on the mod icon to select a new image
document.getElementById('mod-icon').addEventListener('click', () => {
    vscode.postMessage({ type: 'selectIcon' });
});