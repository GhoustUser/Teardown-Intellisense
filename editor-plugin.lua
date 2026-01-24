--- this file is copied from the game files.
--- `Teardown`/`data`/`td_vscode_plugin.lua`
--- Included here to avoid needing to access game files.

--[[
Plugin for sumneko/Lua VSCode extension.

For now this plugin just replaces "#include" with "require()",
it does not behave exactly same as in game,
and will be improved in future releases,
but works fine with relative paths.

Add next settings to ".luarc.json" in project's root folder and replace paths.
{
    "runtime.version": "Lua 5.1",
    "runtime.plugin": "path/to/td_vscode_plugin.lua",
    "workspace.library": [
        "path/to/script_defs.lua",
        "path/to/voxscript_defs.lua"
    ]
}
--]]

function OnSetText(uri, text)
    local diffs = {}

    for start, path, finish in text:gmatch '()#include%s+"([^"]+)"()' do
        diffs[#diffs + 1] = {
            start  = start,
            finish = finish - 1,
            text   = ('require("%s")'):format(path),
        }
    end

    if #diffs == 0 then
        return nil
    end

    return diffs
end
