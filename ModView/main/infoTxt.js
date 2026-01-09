class InfoTxt {
    constructor() {
        /** Name of the mod @type {string} */
        this.name = '';
        /** Name of the author @type {string} */
        this.author = '';
        /** Description of the mod @type {string} */
        this.description = '';
        /** Tag list @type {string[]} */
        this.tags = [];
        /** Version number @type {number} */
        this.version = 0;

        /** @type {string} */
        this.fullText = '';

        /** List of field keys in info.txt @type {["name", "author", "description", "tags", "version"]} */
        this.fieldKeys = ['name', 'author', 'description', 'tags', 'version'];
    }

    /** Returns the value of a field as a string. 
     * @param {'name' | 'author' | 'description' | 'tags' | 'version'} key - The field key to get the value for.
     * @returns {string} - The value of the field as a string.
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
     * @param {(key:string,value:(string | string[] | number))=>void} callback - The callback function to execute for each field.
     * @returns {void}
     */
    forEach(callback) {
        if (!callback || typeof callback !== 'function') return;
        for (let key of this.fieldKeys) {
            callback(key, this[key]);
        }
    }

    /** Parses the content of info.txt
     * @param {string} content - The content of info.txt to parse.
     * @returns {void}
     */
    parseFile(content) {
        this.fullText = content;
        const lines = content.split('\n');
        // iterate through each line from info.txt
        lines.forEach(line => {
            line = line.trim();
            // skip empty lines, comments and lines without '='
            if (line === '' || line.startsWith('#') || !line.includes('=')) return;

            // parse key and value from line
            const [lineKey, lineValue] = line.split('=', 2).map(s => s.trim());
            // check if lineKey is a valid field
            if (this.fieldKeys.includes(lineKey)) {
                switch (lineKey) {
                    case 'tags':
                        this.tags = lineValue.split(' ').map(tag => tag.trim());
                        break;
                    case 'version':
                        this.version = parseInt(lineValue) || 0;
                        break;
                    default:
                        this[lineKey] = lineValue;
                        break;
                }
            }
        });
    }
    parseWebview() {

    }
}


/**
 * Fields object to hold mod info values.
 * @type {{name: string, author: string, description: string, tags: string[], version: number, asString: function, forEach: function}}
 */
let fields = {
    name: '',
    author: '',
    description: '',
    tags: [],
    version: 0,
    /**
     * Returns the field value as a string.
     * @param {'name' | 'author' | 'description' | 'tags' | 'version'} key 
     * @returns 
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
    },
    /**
     * Iterates over each field and executes the callback.
     * @param {(callback: (key: string, value: any) => void)} callback - The callback function to execute for each field.
     * @returns {void}
     */
    forEach(callback) {
        if (!callback || typeof callback !== 'function') return; // validate callback
        // iterate over each key in fields
        for (let key of Object.keys(this)) {
            if (typeof this[key] === 'function') continue; // skip functions
            if (this.hasOwnProperty(key)) // check if property exists
                callback(key, this[key]);
        }
    },
    asArray() {
        const arr = [];
        this.forEach((key, value) => {
            if (typeof value === 'function') return;
            arr.push([key, value]);
        });
        return arr;
    }
};