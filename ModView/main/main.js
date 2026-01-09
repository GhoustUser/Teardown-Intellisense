const vscode = acquireVsCodeApi();


/**
 * Flag to track unsaved changes.
 * @type {boolean}
 */
let hasUnsavedChanges = false;

/** Text content of info.txt
 * @type {string}
 */
let infoTxt = '';

// add event listener to all input fields to check for changes
fields.forEach((key, value) => {
    // get element
    const element = document.getElementById(`mod-${key}`);
    if (!element) return;
    // add input event listener
    element.addEventListener('input', checkForUnsavedChanges);
});

function checkForUnsavedChanges() {
    let newChanges = false;
    // check if any field value differs from original
    fields.forEach((key, value) => {
        if (newChanges) return; // skip if already found changes
        const el = document.getElementById(`mod-${key}`);
        if (!el) return;
        // compare values
        if (el.value !== fields.asString(key)) {
            newChanges = true; // set flag to true if different
        }
    });
    if (newChanges === hasUnsavedChanges) return hasUnsavedChanges; // no change in state
    hasUnsavedChanges = newChanges;
    // notify extension of unsaved changes
    vscode.postMessage({
        type: 'unsavedChanges',
        data: hasUnsavedChanges
    });
    return hasUnsavedChanges;
}

// function to parse the content into fields
function loadModInfo(content) {
    infoTxt = content;
    const lines = content.split('\n');
    fields = fields || {
        name: 'Mod Name',
        author: 'Mod Author',
        description: 'Description of the mod.',
        tags: ['example', 'mod'],
        version: 1
    };

    // iterate through each line from info.txt
    lines.forEach(line => {
        line = line.trim();
        // skip empty lines, comments and lines without '='
        if (line === '' || line.startsWith('#') || !line.includes('=')) return;

        // match line with any of the field keys
        fields.forEach((key, value) => {
            // if line has key, parse value accordingly
            if (line.replaceAll(' ', '').startsWith(key + '=')) {
                const value = line.split('=')[1].trim();
                switch (key) {
                    // parse tags as array
                    case 'tags':
                        fields.tags = value.split(' ')
                            .map(tag => tag.trim());
                        break;
                    // parse version as integer
                    case 'version':
                        fields.version = parseInt(value) || 1;
                        break;
                    // default case: assign string value
                    default:
                        fields[key] = value;
                        break;
                }
            }
        });
    });

    // set element values to fields
    for (let key of Object.keys(fields)) {
        switch (key) {
            case 'tags':
                document.getElementById('mod-tags').value = fields.tags.join(' ');
                break;
            case 'version':
                document.getElementById('mod-version').value = fields.version;
                break;
            default:
                const element = document.getElementById(`mod-${key}`);
                if (element)
                    element.value = fields[key];
                break;
        }
    }
    vscode.postMessage({
        type: 'infoLoaded',
        data: JSON.stringify(fields)
    });
    hasUnsavedChanges = false;
    return fields;
}

// handle the save button click
document.getElementById('saveButton').addEventListener('click', () => {
    saveModInfo();
});

// listen for keyboard shortcuts for saving
window.addEventListener('keydown', (e) => {
    // if Ctrl or Cmd are pressed
    if ((e.ctrlKey || e.metaKey)) {
        e.preventDefault();
        switch (e.key.toLowerCase()) {
            case 's':
                // trigger save
                saveModInfo();
                break;
            case 'r':
                // trigger reload
                vscode.postMessage({
                    type: 'reload'
                });
                break;
        }
    }
});

/** Saves the mod info by sending it to the extension.
 * @returns {void}
 */
function saveModInfo() {
    let content = '';
    let remainingFields = new Map(fields.asArray());
    
    const lines = infoTxt.split('\n');
    lines.forEach(line => {
        line = line.trim();
        // add unchanged lines directly
        if (line === '' || line.startsWith('#') || !line.includes('=')) {
            content += line + '\n';
            return;
        }
        // check if line corresponds to a field
        let fieldFound = false;
        remainingFields.forEach((value, key) => {
            if (fieldFound) return; // skip if already found
            if (line.replaceAll(' ', '').startsWith(key + '=')) {
                // construct new line with updated value
                content += `${key} = ${fields.asString(key)}\n`;
                remainingFields.delete(key);
                fieldFound = true;
            }
        });
        // if no field found, keep line unchanged
        if (!fieldFound) {
            content += line + '\n';
        }
    });
    // append any remaining fields that were not in the original content
    remainingFields.forEach((value, key) => {
        content += `${key} = ${fields.asString(key)}\n`;
    });
    
    if (!content.endsWith('\n')) 
        content += '\n';
    if (content.endsWith('\n\n'))
        content = content.slice(0, -1);

    // update variables
    infoTxt = content;
    hasUnsavedChanges = false;
    // update fields
    fields.forEach((key, value) => {
        const element = document.getElementById(`mod-${key}`);
        if (element)
            fields[key] = element.value;
    });

    // send save message to extension
    vscode.postMessage({
        type: 'saveModInfo',
        data: content
    });
}

document.getElementById('setting-openByDefault').addEventListener('change', (e) => {
    const isChecked = e.target.checked;
    vscode.postMessage({
        type: 'setting_openByDefault',
        data: isChecked
    });
});