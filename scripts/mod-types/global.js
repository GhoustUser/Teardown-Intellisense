const { LoadScriptingApi } = require("../load-lua-api.js");

function LoadGlobalModData(rootPath, context) {
    console.log("Loading global mod data...");
    LoadScriptingApi(context);
}

module.exports = {
    LoadGlobalModData
};