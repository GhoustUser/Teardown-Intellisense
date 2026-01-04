// import necessary modules
const path = require("path");
const fs = require("fs");

const { LoadInfoTxt } = require("./info-txt.js");


/**
 * The type of mod currently opened
 * @type {"unknown"|"content"|"global"|"character"}
 */
let modType = "unknown";

/**
 * Entry function for loading info about the currently opened mod.
 * @returns {void}
 */
function LoadModData(context, rootPath) {
    // load the info.txt data
    LoadInfoTxt(rootPath).print();
    // determine mod type based on presence of specific files
    if (fs.existsSync(path.join(rootPath, "main.xml"))) {
        modType = "content";
        require("./mod-types/content.js").LoadContentModData(rootPath, context);
    } else if (fs.existsSync(path.join(rootPath, "main.lua"))) {
        modType = "global";
        require("./mod-types/global.js").LoadGlobalModData(rootPath, context);
    } else if (fs.existsSync(path.join(rootPath, "characters.txt"))) {
        modType = "character";
    } else {
        modType = "unknown";
    }
    console.log(`Detected mod type: ${modType}`);
}

module.exports = {
    LoadModData,
    modType
};