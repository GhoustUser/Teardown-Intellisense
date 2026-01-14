class InfoTxt {
    constructor() {
        /** Name of the mod @type {string} */
        this.name = 'Mod Name';
        /** Name of the author @type {string} */
        this.author = 'Mod Author';
        /** Description of the mod @type {string} */
        this.description = 'Description of the mod.';
        /** Tag list @type {string[]} */
        this.tags = ['example', 'mod'];
        /** Version number @type {number} */
        this.version = 1;

        /** Original file content @type {string} */
        this.originalContent = '';

        /** List of field keys in info.txt @type {string[]} */
        this.fieldKeys = ['name', 'author', 'description', 'tags', 'version'];
    }

    /** Returns the value of a field as a string.
     * @param {string} key - The field key to get the value for
     * @returns {string} The value of the field as a string
     */
    asString(key) {
        switch (key) {
            case 'tags':
                return this.tags.join(' ');
            case 'version':
                return this.version.toString();
            default:
                return this[key] || '';
        }
    }

    /** Runs a callback for each field in the InfoTxt.
     * @param {(key: string, value: any) => void} callback - The callback function to execute for each field
     * @returns {void}
     */
    forEach(callback) {
        if (!callback || typeof callback !== 'function') return;
        for (let key of this.fieldKeys) {
            callback(key, this[key]);
        }
    }

    /** Returns field keys and values as an array of [key, value] pairs.
     * @returns {[string, any][]} Array of field entries
     */
    asArray() {
        return this.fieldKeys.map(key => [key, this[key]]);
    }

    /** Parses the content of info.txt and updates field values.
     * @param {string} content - The content of info.txt to parse
     * @returns {void}
     */
    parseFile(content) {
        this.originalContent = content;
        const lines = content.split('\n');
        
        lines.forEach(line => {
            line = line.trim();
            // Skip empty lines, comments and lines without '='
            if (line === '' || line.startsWith('#') || !line.includes('=')) return;

            // Parse key and value from line
            const [lineKey, lineValue] = line.split('=', 2).map(s => s.trim());
            
            // Check if lineKey is a valid field
            if (this.fieldKeys.includes(lineKey)) {
                switch (lineKey) {
                    case 'tags':
                        this.tags = lineValue.split(' ').map(tag => tag.trim()).filter(tag => tag !== '');
                        break;
                    case 'version':
                        this.version = parseInt(lineValue) || 1;
                        break;
                    default:
                        this[lineKey] = lineValue;
                        break;
                }
            }
        });
    }

    /** Updates field values from webview form elements.
     * @returns {void}
     */
    updateFromWebview() {
        this.fieldKeys.forEach(key => {
            const element = document.getElementById(`mod-${key}`);
            if (!element) return;

            switch (key) {
                case 'tags':
                    this.tags = element.value.split(' ').map(tag => tag.trim()).filter(tag => tag !== '');
                    break;
                case 'version':
                    this.version = parseInt(element.value) || 1;
                    break;
                default:
                    this[key] = element.value;
                    break;
            }
        });
    }

    /** Updates webview form elements with current field values.
     * @returns {void}
     */
    updateWebview() {
        this.fieldKeys.forEach(key => {
            const element = document.getElementById(`mod-${key}`);
            if (!element) return;

            switch (key) {
                case 'tags':
                    element.value = this.tags.join(' ');
                    break;
                default:
                    element.value = this[key];
                    break;
            }
        });
    }

    /** Generates the complete info.txt file content with current field values.
     * @returns {string} The complete file content
     */
    generateFileContent() {
        let content = '';
        let remainingFields = new Map(this.asArray());
        
        const lines = this.originalContent.split('\n');
        lines.forEach(line => {
            const trimmedLine = line.trim();
            
            // Add unchanged lines directly
            if (trimmedLine === '' || trimmedLine.startsWith('#') || !trimmedLine.includes('=')) {
                content += line + '\n';
                return;
            }
            
            // Check if line corresponds to a field
            let fieldFound = false;
            remainingFields.forEach((value, key) => {
                if (fieldFound) return;
                if (trimmedLine.replaceAll(' ', '').startsWith(key + '=')) {
                    content += `${key} = ${this.asString(key)}\n`;
                    remainingFields.delete(key);
                    fieldFound = true;
                }
            });
            
            // If no field found, keep line unchanged
            if (!fieldFound) {
                content += line + '\n';
            }
        });
        
        // Append any remaining fields that were not in the original content
        remainingFields.forEach((value, key) => {
            content += `${key} = ${this.asString(key)}\n`;
        });
        
        // Clean up trailing newlines
        if (!content.endsWith('\n')) {
            content += '\n';
        }
        if (content.endsWith('\n\n')) {
            content = content.slice(0, -1);
        }
        
        return content;
    }

    /** Checks if current webview values differ from stored field values.
     * @returns {boolean} True if there are unsaved changes
     */
    hasUnsavedChanges() {
        return this.fieldKeys.some(key => {
            const element = document.getElementById(`mod-${key}`);
            if (!element) return false;
            
            switch (key) {
                case 'tags':
                    const webviewTags = element.value.split(' ').map(tag => tag.trim()).filter(tag => tag !== '');
                    return JSON.stringify(webviewTags) !== JSON.stringify(this.tags);
                case 'version':
                    return parseInt(element.value) !== this.version;
                default:
                    return element.value !== this[key];
            }
        });
    }
}