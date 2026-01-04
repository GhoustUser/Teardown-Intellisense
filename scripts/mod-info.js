const path = require("path");
const fs = require("fs");

/**
 * Instance of InfoTxt containing mod information
 * @type {InfoTxt|null}
 */
let infoTxt = null;

/**
 * Loads mod info from the info.txt file in the mod root directory.
 * Parses key-value pairs and stores them as properties.
 * @class InfoTxt
 * @property {string} name - The name of the mod.
 * @property {string} author - The author of the mod.
 * @property {string} description - The description of the mod.
 * @property {Array<string>} tags - An array of tags associated with the mod.
 * @property {number} version - The version number of the mod.
 * @method print - Prints the mod information to the console.
 */
class InfoTxt {
    /**
     * Creates an instance of InfoTxt by reading and parsing the info.txt file.
     * @param {string} path - the file path to the info.txt file.
     */
    constructor(path) {
        // read the info.txt file
        /** @type {string} */
        const infoTxt = fs.readFileSync(path, "utf-8");
        const lines = infoTxt.split("\n");

        // temporary storage for key-value pairs
        let data = {};
        lines.forEach(line => {
            if (line.trim() === "" || line.startsWith("#")) return; // skip empty lines and comments
            const [key, value] = line.split("=").map(part => part.trim());
            if (key && value) {
                data[key] = value;
            }
        });

        // assign properties
        this.name = data["name"] || "unknown";
        this.author = data["author"] || "unknown";
        this.description = data["description"] || "unknown";
        this.tags = data["tags"] ? data["tags"].split(" ").map(tag => tag.trim()) : [];
        this.version = parseInt(data["version"]) || 1;
    }
    print() {
        console.log(`Mod Name: ${this.name}`);
        console.log(`Author: ${this.author}`);
        console.log(`Description: ${this.description}`);
        console.log(`Tags: ${this.tags.join(", ")}`);
        console.log(`Version: ${this.version}`);
    }
}

/**
 * Loads and returns an InfoTxt instance for the mod at the given root path.
 * @param {string} rootPath 
 * @returns {InfoTxt}
 */
function LoadInfoTxt(rootPath) {
    // root path of the current workspace
    const infoTxtPath = path.join(rootPath, "info.txt");
    infoTxt = new InfoTxt(infoTxtPath);
    return infoTxt;
}

module.exports = {
    LoadInfoTxt,
    infoTxt
};