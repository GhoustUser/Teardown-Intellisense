--- @meta


--- The Teardown engine uses a global key/value-pair registry that scripts can read and write.
--- The engine exposes a lot of internal information through the registry, but it can also be used
--- as way for scripts to communicate with each other.
--- The registry is a hierarchical node structure and can store a value in each node (parent nodes can also have a value).
--- The values can be of type floating point number, integer, boolean or string, but all types are automatically converted if another type is requested. Some registry nodes are reserved and used for special purposes.
--- Registry node names may only contain the characters a-z, numbers 0-9, dot, dash and underscore.


--- @alias Registry_Key
--- | 'options' Reserved for game settings (write protected from mods)
--- | 'game' Reserved for the game engine internals (see documentation)
--- | 'savegame' Used for persistent game data (write protected for mods)
--- | 'savegame.mod' Used for persistent mod data. Use only alphanumeric character for key name.
--- | 'level' Not reserved, but recommended for level specific entries and script communication
--- | string Any registry key


--- @alias LoadLanguageTable_Id
--- | 0 English
--- | 1 French
--- | 2 Spanish
--- | 3 Italian
--- | 4 German
--- | 5 Simplified Chinese
--- | 6 Japanese
--- | 7 Russian
--- | 8 Polish


--- ### Example
--- ```lua
--- function init()
--- 	--If the registry looks like this:
--- 	--	score
--- 	--		levels
--- 	--			level1 = 5
--- 	--			level2 = 4
--- 	ClearKey("score.levels")
--- 	--Afterwards, the registry will look like this:
--- 	--	score
--- end
--- ```
--- Remove registry node, including all child nodes.
--- @param key Registry_Key -- Registry key to clear
--- [View Documentation](https://teardowngame.com/experimental/api.html#ClearKey)
function ClearKey(key) end

--- List all child keys of a registry node.
--- ### Example
--- ```lua
--- --If the registry looks like this:
--- --	game
--- --		tool
--- --			steroid
--- --			rifle
--- --			...
--- function init()
--- 	local list = ListKeys("game.tool")
--- 	for i=1, #list do
--- 		DebugPrint(list[i])
--- 	end
--- end
--- --This will output:
--- --steroid
--- --rifle
--- -- ...
--- ```
--- @param parent string -- The parent registry key
--- @return table children -- Indexed table of strings with child keys
--- [View Documentation](https://teardowngame.com/experimental/api.html#ListKeys)
function ListKeys(parent) end

--- Returns true if the registry contains a certain key
--- ### Example
--- ```lua
--- function init()
--- 	DebugPrint(HasKey("score.levels"))
--- 	DebugPrint(HasKey("game.tool.rifle"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @return boolean exists -- True if key exists
--- [View Documentation](https://teardowngame.com/experimental/api.html#HasKey)
function HasKey(key) end

--- ### Example
--- ```lua
--- function init()
--- 	SetInt("score.levels.level1", 4)
--- 	DebugPrint(GetInt("score.levels.level1"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @param value number -- Desired value
--- @param sync? boolean -- Synchronize to clients
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetInt)
function SetInt(key, value, sync) end

--- ### Example
--- ```lua
--- function init()
--- 	SetInt("score.levels.level1", 4)
--- 	DebugPrint(GetInt("score.levels.level1"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @return number value -- Integer value of registry node or zero if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetInt)
function GetInt(key) end

--- ### Example
--- ```lua
--- function init()
--- 	SetFloat("level.time", 22.3)
--- 	DebugPrint(GetFloat("level.time"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @param value number -- Desired value
--- @param sync? boolean -- Synchronize to clients
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetFloat)
function SetFloat(key, value, sync) end

--- ### Example
--- ```lua
--- function init()
--- 	SetFloat("level.time", 22.3)
--- 	DebugPrint(GetFloat("level.time"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @return number value -- Float value of registry node or zero if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetFloat)
function GetFloat(key) end

--- ### Example
--- ```lua
--- function init()
--- 	SetBool("level.robots.enabled", true)
--- 	DebugPrint(GetBool("level.robots.enabled"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @param value boolean -- Desired value
--- @param sync? boolean -- Synchronize to clients
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBool)
function SetBool(key, value, sync) end

--- ### Example
--- ```lua
--- function init()
--- 	SetBool("level.robots.enabled", true)
--- 	DebugPrint(GetBool("level.robots.enabled"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @return boolean value -- Boolean value of registry node or false if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBool)
function GetBool(key) end

--- ### Example
--- ```lua
--- function init()
--- 	SetString("level.name", "foo")
--- 	DebugPrint(GetString("level.name"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @param value string -- Desired value
--- @param sync? boolean -- Synchronize to clients
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetString)
function SetString(key, value, sync) end

--- ### Example
--- ```lua
--- function init()
--- 	SetString("level.name", "foo")
--- 	DebugPrint(GetString("level.name"))
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @return string value -- String value of registry node or "" if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetString)
function GetString(key) end

--- Sets the color registry key value
--- ### Example
--- ```lua
--- function init()
--- 	SetColor("game.tool.wire.color", 1.0, 0.5, 0.3)
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @param r number -- Desired red channel value
--- @param g number -- Desired green channel value
--- @param b number -- Desired blue channel value
--- @param a? number -- Desired alpha channel value
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetColor)
function SetColor(key, r, g, b, a) end

--- Returns the color registry key value
--- ### Example
--- ```lua
--- function init()
--- 	SetColor("red", 1.0, 0.1, 0.1)
--- 	color = GetColor("red")
--- 	DebugPrint("RGBA: " .. color[1] .. " " .. color[2] .. " " .. color[3] .. " " .. color[4])
--- end
--- ```
--- @param key Registry_Key -- Registry key
--- @return number r -- Desired red channel value
--- @return number g -- Desired green channel value
--- @return number b -- Desired blue channel value
--- @return number a -- Desired alpha channel value
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetColor)
function GetColor(key) end

--- Returns the translation for the specified key from the translation table. If the key is not found returns the default value
--- ### Example
--- ```lua
--- function init()
--- 	DebugPrint(GetTranslatedStringByKey("TOOL_CAMERA"))
--- end
--- ```
--- @param key Registry_Key -- Translation key
--- @param default? string -- Default value
--- @return string value -- Translation
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTranslatedStringByKey)
function GetTranslatedStringByKey(key, default) end

--- Checks that translation for specified key exists
--- ### Example
--- ```lua
--- function init()
--- 	DebugPrint(HasTranslationByKey("TOOL_CAMERA"))
--- end
--- ```
--- @param key Registry_Key -- Translation key
--- @return boolean value -- True if translation exists
--- [View Documentation](https://teardowngame.com/experimental/api.html#HasTranslationByKey)
function HasTranslationByKey(key) end

--- ### Example
--- ```lua
--- function init()
--- 	-- loads the english localization table
--- 	LoadLanguageTable(0)
--- end
--- ```
--- @param id LoadLanguageTable_Id -- Language id (enum)
--- [View Documentation](https://teardowngame.com/experimental/api.html#LoadLanguageTable)
function LoadLanguageTable(id) end

--- Returns the user nickname with the specified id. If id is not specified, returns nickname for user with id '0'
--- ### Example
--- ```lua
--- function init()
--- 	DebugPrint(GetUserNickname(0))
--- end
--- ```
--- @param id? number -- User id
--- @return string value -- User nickname
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetUserNickname)
function GetUserNickname(id) end
