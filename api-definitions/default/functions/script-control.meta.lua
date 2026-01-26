--- @meta


--- General functions that control the operation and flow of the script.


---@alias InputIdentifier ScriptControl_PhysicalInput | ScriptControl_LogicalInput

--- ### Example
--- ```lua
--- function init()
--- 	local v = GetVersion()
--- 	--v is "0.5.0"
--- 	DebugPrint(v)
--- end
--- ```
--- @alias ScriptControl_PhysicalInput
--- | 'esc' Escape key
--- | 'tab' Tab key
--- | 'lmb' Left mouse button
--- | 'rmb' Right mouse button
--- | 'mmb' Middle mouse button
--- | 'uparrow' Up arrow key
--- | 'downarrow' Down arrow key
--- | 'leftarrow' Left arrow key
--- | 'rightarrow' Right arrow key
--- | 'backspace' Backspace key
--- | 'alt' Alt key
--- | 'delete' Delete key
--- | 'home' Home key
--- | 'end' End key
--- | 'pgup' Pgup key
--- | 'pgdown' Pgdown key
--- | 'insert' Insert key
--- | 'space' Space bar
--- | 'shift' Shift key
--- | 'ctrl' Ctrl key
--- | 'return' Return key
--- | 'mousedx' Mouse horizontal diff. Only valid in InputValue.
--- | 'mousedy' Mouse vertical diff. Only valid in InputValue.
--- | 'mousewheel' Mouse wheel. Only valid in InputValue.
--- | 'a' A Character key
--- | 'b' B Character key
--- | 'c' C Character key
--- | 'd' D Character key
--- | 'e' E Character key
--- | 'f' F Character key
--- | 'g' G Character key
--- | 'h' H Character key
--- | 'i' I Character key
--- | 'j' J Character key
--- | 'k' K Character key
--- | 'l' L Character key
--- | 'm' M Character key
--- | 'n' N Character key
--- | 'o' O Character key
--- | 'p' P Character key
--- | 'q' Q Character key
--- | 'r' R Character key
--- | 's' S Character key
--- | 't' T Character key
--- | 'u' U Character key
--- | 'v' V Character key
--- | 'w' W Character key
--- | 'x' X Character key
--- | 'y' Y Character key
--- | 'z' Z Character key
--- | '0' 0 Digit key
--- | '1' 1 Digit key
--- | '2' 2 Digit key
--- | '3' 3 Digit key
--- | '4' 4 Digit key
--- | '5' 5 Digit key
--- | '6' 6 Digit key
--- | '7' 7 Digit key
--- | '8' 8 Digit key
--- | '9' 9 Digit key
--- | 'f1' Function key 1
--- | 'f2' Function key 2
--- | 'f3' Function key 3
--- | 'f4' Function key 4
--- | 'f5' Function key 5
--- | 'f6' Function key 6
--- | 'f7' Function key 7
--- | 'f8' Function key 8
--- | 'f9' Function key 9
--- | 'f10' Function key 10
--- | 'f11' Function key 11
--- | 'f12' Function key 12
--- | string Any key or button

--- @alias ScriptControl_LogicalInput
--- | 'up' Move forward / Accelerate
--- | 'down' Move backward / Brake
--- | 'left' Move left
--- | 'right' Move right
--- | 'interact' Interact
--- | 'flashlight' Flashlight
--- | 'jump' Jump
--- | 'crouch' Crouch
--- | 'usetool' Use tool
--- | 'grab' Grab
--- | 'handbrake' Handbrake
--- | 'map' Map
--- | 'pause' Pause game (escape)
--- | 'vehicleraise' Raise vehicle parts
--- | 'vehiclelower' Lower vehicle parts
--- | 'vehicleaction' Vehicle action
--- | 'camerax' Camera x movement, scaled by sensitivity. Only valid in InputValue.
--- | 'cameray' Camera y movement, scaled by sensitivity. Only valid in InputValue.
--- | 'tool_group_prev' Switch to previous tool group
--- | 'tool_group_next' Switch to next tool group
--- | 'extra0' Extra action 0
--- | 'extra1' Extra action 1
--- | 'extra2' Extra action 2
--- | 'extra3' Extra action 3
--- | 'extra4' Extra action 4
--- | 'extra5' Extra action 5
--- | 'extra6' Extra action 6
--- | 'photomode' Photomode
--- | 'zoom' Zoom
--- | 'menu_left' Menu left
--- | 'menu_right' Menu right
--- | 'menu_up' Menu up
--- | 'menu_down' Menu down
--- | 'menu_next' Menu next
--- | 'menu_prev' Menu prev
--- | 'menu_accept' Menu accept
--- | 'menu_cancel' Menu cancel

--- @alias SetValue_Transition
--- | 'linear' Linear transition
--- | 'cosine' Slow at beginning and end
--- | 'easein' Slow at beginning
--- | 'easeout' Slow at end
--- | 'bounce' Bounce and overshoot new value

--- @return string version -- Dot separated string of current version of the game
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVersion)
function GetVersion() end

--- ### Example
--- ```lua
--- function init()
--- 	if HasVersion("1.5.0") then
--- 		--conditional code that only works on 0.6.0 or above
--- 		DebugPrint("New version")
--- 	else
--- 		--legacy code that works on earlier versions
--- 		DebugPrint("Earlier version")
--- 	end
--- end
--- ```
--- @param version string -- Reference version
--- @return boolean match -- True if current version is at least provided one
--- [View Documentation](https://teardowngame.com/experimental/api.html#HasVersion)
function HasVersion(version) end

--- Returns running time of this script. If called from update, this returns
--- the simulated time, otherwise it returns wall time.
--- ### Example
--- ```lua
--- function client.update()
--- 	local t = GetTime()
--- 	DebugPrint(t)
--- end
--- ```
--- @return number time -- The time in seconds since level was started
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTime)
function GetTime() end

--- Returns timestep of the last frame. If called from update, this returns
--- the simulation time step, which is always one 60th of a second (0.0166667).
--- If called from tick or draw it returns the actual time since last frame.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local dt = GetTimeStep()
--- 	DebugPrint("tick dt: " .. dt)
--- end
--- function client.update()
--- 	local dt = GetTimeStep()
--- 	DebugPrint("update dt: " .. dt)
--- end
--- ```
--- @return number dt -- The timestep in seconds
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTimeStep)
function GetTimeStep() end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local name = InputLastPressedKey()
--- 	if string.len(name) > 0 then
--- 		DebugPrint(name)
--- 	end
--- end
--- ```
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return string name -- Name of last pressed key, empty if no key is pressed
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputLastPressedKey)
function InputLastPressedKey(playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		DebugPrint("interact")
--- 	end
--- end
--- ```
--- @param input InputIdentifier -- The input identifier
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean pressed -- True if input was pressed during last frame
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputPressed)
function InputPressed(input, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	if InputReleased("interact") then
--- 		DebugPrint("interact")
--- 	end
--- end
--- ```
--- @param input InputIdentifier -- The input identifier
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean pressed -- True if input was released during last frame
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputReleased)
function InputReleased(input, playerId) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	if InputDown("interact") then
--- 		DebugPrint("interact")
--- 	end
--- end
--- ```
--- @param input InputIdentifier -- The input identifier
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return boolean pressed -- True if input is currently held down
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputDown)
function InputDown(input, playerId) end

--- ### Example
--- ```lua
--- local scrollPos = 0
--- function client.tick()
--- 	scrollPos = scrollPos + InputValue("mousewheel")
--- 	DebugPrint(scrollPos)
--- end
--- ```
--- @param input InputIdentifier -- The input identifier
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number value -- Depends on input type
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputValue)
function InputValue(input, playerId) end

--- ### CLIENT ONLY
--- All player input is "forgotten" by the game after calling this function
--- ### Example
--- ```lua
--- function client.update()
--- 	-- Prints '2' because InputClear() allows the game to "forget" the player's input
--- 	if InputDown("interact") then
--- 		InputClear()
--- 		if InputDown("interact") then
--- 			DebugPrint(1)
--- 		else
--- 			DebugPrint(2)
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputClear)
function InputClear() end

--- ### CLIENT ONLY
--- This function will reset everything we need to reset during state transition
--- ### Example
--- ```lua
--- function update()
--- 	if InputDown("interact") then
--- 		-- In this form, you won't be able to notice the result of the function; you need a specific context
--- 		InputResetOnTransition()
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#InputResetOnTransition)
function InputResetOnTransition() end

--- Returns the last input device id.
--- 0 - none, 1 - mouse, 2 - gamepad
--- ### Example
--- ```lua
--- #include "ui/ui_helpers.lua"
--- function client.update()
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		DebugPrint("Last input was from gamepad")
--- 	elseif LastInputDevice() == UI_DEVICE_MOUSE then
--- 		DebugPrint("Last input was mouse & keyboard")
--- 	elseif LastInputDevice() == UI_DEVICE_TOUCHSCREEN then
--- 		DebugPrint("Last input was touchscreen")
--- 	end
--- end
--- ```
--- @return number value -- Last device id
--- [View Documentation](https://teardowngame.com/experimental/api.html#LastInputDevice)
function LastInputDevice() end

--- ### Example
--- ```lua
--- myValue = 0
--- function client.tick()
--- 	--This will change the value of myValue from 0 to 1 in a linear fasion over 0.5 seconds
--- 	SetValue("myValue", 1, "linear", 0.5)
--- 	DebugPrint(myValue)
--- end
--- ```
--- @param variable string -- Name of number variable in the global context
--- @param value number -- The new value
--- @param transition? SetValue_Transition -- Transition type. See description.
--- @param time? number -- Transition time (seconds)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetValue)
function SetValue(variable, value, transition, time) end

--- Chages the value of a table member in time according to specified args.
--- Works similar to SetValue but for global variables of trivial types
--- ### Example
--- ```lua
--- local t = {}
--- function init()
--- 	SetValueInTable(t, "score", 1, "number", 1)
--- end
--- function update()
--- 	if InputPressed("interact") then
--- 		SetValueInTable(t, "score", t.score + 1, "number", 1)
--- 		DebugPrint(t.score)
--- 	end
--- end
--- ```
--- @param tableId table -- Id of the table
--- @param memberName string -- Name of the member
--- @param newValue number -- New value
--- @param type string -- Transition type
--- @param length number -- Transition length
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetValueInTable)
function SetValueInTable(tableId, memberName, newValue, type, length) end

--- Calling this function will add a button on the bottom bar or in the main pause menu (center of the screen) when the game is paused.
--- Identified by 'location' parameter, it can be below "Main menu" button (by passing "main_bottom" value)or above (by passing "main_top").
--- A primary button will be placed in the main pause menu if this function is called from a playable mod. There can be only one primary button.
--- Use this as a way to bring up mod settings or other user interfaces while the game is running.
--- Call this function every frame from the tick function for as long as the pause menu button
--- should still be visible.
--- Only one button per script is allowed. Consecutive calls replace button added in previous calls.
--- ### Example
--- ```lua
--- function server.startLevel(mission, path)
--- 	StartLevel(mission, path)
--- end
--- function server.respawnPlayer(player)
--- 	-- Respawn player
--- end
--- function client.tick()
--- 	for p in Players() do
--- 		if IsPlayerHost(p) then
--- 			-- Primary button which will be placed in the main pause menu below "Main menu" button
--- 			if PauseMenuButton("Back to Hub", "main_bottom") then
--- 				ServerCall("server.startLevel", "hub", "level/hub.xml")
--- 			end
--- 			-- Primary button which will be placed in the main pause menu above "Main menu" button
--- 			if PauseMenuButton("Back to Hub", "main_top") then
--- 				ServerCall("server.startLevel", "hub", "level/hub.xml")
--- 			end
--- 			-- Button will be placed in the bottom bar of the pause menu
--- 			if PauseMenuButton("MyMod Settings") then
--- 				visible = true
--- 			end
--- 		else
--- 			if PauseMenuButton("Respawn (wait 8s)", "bottom_bar", true) then
--- 				ServerCall("server.respawnPlayer", p)
--- 			end
--- 		end
--- 	end
--- end
--- function draw()
--- 	if visible then
--- 		UiMakeInteractive()
--- 	end
--- end
--- ```
--- @param title string -- Text on button
--- @param location? string -- Button location. If "bottom_bar" - bottom bar, if "main_bottom" - below "Main menu" button, if "main_top" - above "Main menu" button. Default "bottom_bar".
--- @param disabled? boolean -- Disable button. Button will be rendered as grayed out. Default is false. Only available when used with "bottom_bar".
--- @return boolean clicked -- True if clicked, false otherwise
--- [View Documentation](https://teardowngame.com/experimental/api.html#PauseMenuButton)
function PauseMenuButton(title, location, disabled) end

--- Checks that file exists on the specified path.
--- It is preferable to use UiHasImage whenever possible - it has better performance
--- ### Example
--- ```lua
--- local file = "gfx/circle.png"
--- function draw()
--- 	if HasFile(image) then
--- 		DebugPrint("file " .. file .. " exists")
--- 	end
--- end
--- ```
--- @param path string -- Path to file
--- @return boolean exists -- True if file exists
--- [View Documentation](https://teardowngame.com/experimental/api.html#HasFile)
function HasFile(path) end

--- Start a level
--- ### Example
--- ```lua
--- function server.init()
--- 	--Start level with no active layers
--- 	StartLevel("level1", "MOD/level1.xml")
--- 	--Start level with two layers
--- 	StartLevel("level1", "MOD/level1.xml", "vehicles targets")
--- end
--- ```
--- @param mission string -- An identifier of your choice
--- @param path string -- Path to level XML file
--- @param layers? string -- Active layers. Default is no layers.
--- @param passThrough? boolean -- If set, loading screen will have no text and music will keep playing
--- [View Documentation](https://teardowngame.com/experimental/api.html#StartLevel)
function StartLevel(mission, path, layers, passThrough) end

--- Set paused state of the game
--- ### Example
--- ```lua
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		--Pause game and bring up pause menu on HUD
--- 		SetPaused(true)
--- 	end
--- end
--- ```
--- @param paused boolean -- True if game should be paused
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPaused)
function SetPaused(paused) end

--- Restart level
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("interact") then
--- 		Restart()
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#Restart)
function Restart() end

--- Go to main menu
--- ### Example
--- ```lua
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		Menu()
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#Menu)
function Menu() end

--- ### Example
--- ```lua
--- function server.tick()
--- 	for p in Players() do
--- 		if GetPlayerHealth(p) == 0) then
--- 			ClientCall(p, "client.showRespawnBtn")
--- 		end
--- 	end
--- 	if matchEnded then
--- 		ClientCall(0, "client.displayParticles", "confetti", 200, 0.3, Vec(0, 30, 0))
--- 	end
--- end
--- function client.showRespawnBtn()
--- 	-- show respawn ui..
--- end
--- function client.displayParticles(particleName, amount, life, pos)
--- 	-- spawn particles..
--- end
--- ```
--- @param playerId number -- Player ID of the recipient. Use 0 to broadcast to every player.
--- @param function_arg string -- Name of the function to be invoked. This function must exist within issuing script.
--- @param ...? any -- Optional parameters to send to the recipent(s). Arguments should match the signature of the specified function.
--- [View Documentation](https://teardowngame.com/experimental/api.html#ClientCall)
function ClientCall(playerId, function_arg, ...) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	if UiTextButton("I am Ready") then
--- 		ServerCall("server.setPlayerReady", GetLocalPlayer())
--- 	end
--- end
--- function server.setPlayerReady(playerId)
--- 	shared.playersReady[playerId] = true
--- end
--- ```
--- @param function_arg string -- Name of the function to be invoked. This function must exist within issuing script.
--- @param ...? any -- Optional parameters to send to the server. Arguments should match the signature of the specified function.
--- [View Documentation](https://teardowngame.com/experimental/api.html#ServerCall)
function ServerCall(function_arg, ...) end

