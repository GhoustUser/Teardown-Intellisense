const vscode = acquireVsCodeApi();

/** @type {InfoTxt} */
let modInfo = new InfoTxt();

/** @type {boolean} */
let hasUnsavedChanges = false;

// Initialize the webview
function initializeWebview() {
    setupEventListeners();
    setupKeyboardShortcuts();
}

// Set up all event listeners
function setupEventListeners() {
    // Add change listeners to all input fields
    modInfo.fieldKeys.forEach(key => {
        const element = document.getElementById(`mod-${key}`);
        if (element) {
            element.addEventListener('input', checkForUnsavedChanges);
        }
    });

    // Save button event listener
    document.getElementById('saveButton').addEventListener('click', saveModInfo);

    // Settings event listeners
    document.getElementById('setting-openByDefault').addEventListener('change', (e) => {
        vscode.postMessage({
            type: 'setting_openByDefault',
            data: e.target.checked
        });
    });

    document.getElementById('setting-enableScriptingApi').addEventListener('change', (e) => {
        vscode.postMessage({
            type: 'setting_enableScriptingApi',
            data: e.target.checked
        });
    });
}

// Set up keyboard shortcuts
function setupKeyboardShortcuts() {
    window.addEventListener('keydown', (e) => {
        if (e.ctrlKey || e.metaKey) {
            e.preventDefault();
            switch (e.key.toLowerCase()) {
                case 's':
                    saveModInfo();
                    break;
                case 'r':
                    vscode.postMessage({ type: 'reload' });
                    break;
            }
        }
    });
}

/** Check for unsaved changes and notify extension
 * @returns {boolean} Whether there are unsaved changes
 */
function checkForUnsavedChanges() {
    const newChanges = modInfo.hasUnsavedChanges();
    
    if (newChanges === hasUnsavedChanges) {
        return hasUnsavedChanges; // No change in state
    }
    
    hasUnsavedChanges = newChanges;
    
    // Notify extension of unsaved changes
    vscode.postMessage({
        type: 'unsavedChanges',
        data: hasUnsavedChanges
    });
    
    return hasUnsavedChanges;
}

/** Load mod info from content and update the UI
 * @param {string} content - The info.txt file content
 * @returns {InfoTxt} The parsed mod info
 */
function loadModInfo(content) {
    modInfo.parseFile(content);
    modInfo.updateWebview();
    
    vscode.postMessage({
        type: 'infoLoaded',
        data: JSON.stringify({
            name: modInfo.name,
            author: modInfo.author,
            description: modInfo.description,
            tags: modInfo.tags,
            version: modInfo.version
        })
    });
    
    hasUnsavedChanges = false;
    return modInfo;
}

/** Save the current mod info to file
 * @returns {void}
 */
function saveModInfo() {
    // Update modInfo with current webview values
    modInfo.updateFromWebview();
    
    // Generate file content
    const content = modInfo.generateFileContent();
    
    // Update original content for future saves
    modInfo.originalContent = content;
    hasUnsavedChanges = false;
    
    // Send save message to extension
    vscode.postMessage({
        type: 'saveModInfo',
        data: content
    });
}

/** Handle settings update
 * @param {object} settings - Settings object from extension
 * @returns {void}
 */
function updateSettings(settings) {
    if (settings.openByDefault !== undefined) {
        document.getElementById('setting-openByDefault').checked = settings.openByDefault;
    }
    if (settings.enableScriptingApi !== undefined) {
        document.getElementById('setting-enableScriptingApi').checked = settings.enableScriptingApi;
    }
}

// Initialize when page loads
initializeWebview();