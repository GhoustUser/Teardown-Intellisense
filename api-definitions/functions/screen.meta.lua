--- @meta


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first screen with specified tag or zero if not found
--- ### Example
--- ```lua
--- function client.init()
--- 	local screen = FindScreen("tv")
--- 	DebugPrint(screen)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindScreen)
function FindScreen(tag, global) end

--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all screens with specified tag
--- ### Example
--- ```lua
--- function client.init()
--- 	--Find screens tagged "tv" in script scope
--- 	local screens = FindScreens("tv")
--- 	for i=1, #screens do
--- 		local screen = screens[i]
--- 		DebugPrint(screen)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindScreens)
function FindScreens(tag, global) end

--- ### SERVER ONLY
--- Enable or disable screen
--- @param screen number -- Screen handle
--- @param enabled boolean -- True if screen should be enabled
--- ### Example
--- ```lua
--- function server.init()
--- 	SetScreenEnabled(FindScreen("tv"), true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetScreenEnabled)
function SetScreenEnabled(screen, enabled) end

--- @param screen number -- Screen handle
--- @return boolean enabled -- True if screen is enabled
--- ### Example
--- ```lua
--- function client.init()
--- 	local b = IsScreenEnabled(FindScreen("tv"))
--- 	DebugPrint(b)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsScreenEnabled)
function IsScreenEnabled(screen) end

--- Return handle to the parent shape of a screen
--- @param screen number -- Screen handle
--- @return number shape -- Shape handle or zero if none
--- ### Example
--- ```lua
--- local screen = 0
--- function client.init()
--- 	screen = FindScreen("tv")
--- 	local shape = GetScreenShape(screen)
--- 	DebugPrint(shape)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetScreenShape)
function GetScreenShape(screen) end

--- Return playerId that interacts with a screen, or zero if not interacted with
--- @param screen number -- Screen handle
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- local player = GetScreenPlayer(screen)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetScreenPlayer)
function GetScreenPlayer(screen, playerId) end

