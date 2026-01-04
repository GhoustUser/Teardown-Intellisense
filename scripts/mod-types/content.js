const { LoadScriptingApi } = require("../load-lua-api.js");

function LoadContentModData(rootPath, context) {
    console.log("Loading content mod data...");
    LoadScriptingApi(context);
}

module.exports = {
    LoadContentModData
};