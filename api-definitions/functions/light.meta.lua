--- @meta


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first light with specified tag or zero if not found
--- ### Example
--- ```lua
--- function client.init()
--- 	local light = FindLight("main")
--- 	DebugPrint(light)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindLight)
function FindLight(tag, global) end

--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all lights with specified tag
--- ### Example
--- ```lua
--- function client.init()
--- 	--Search for lights tagged "main" in script scope
--- 	local lights = FindLights("main")
--- 	for i=1, #lights do
--- 		local light = lights[i]
--- 		DebugPrint(light)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindLights)
function FindLights(tag, global) end

--- If light is owned by a shape, the emissive scale of that shape will be set
--- to 0.0 when light is disabled and 1.0 when light is enabled.
--- @param handle number -- Light handle
--- @param enabled boolean -- Set to true if light should be enabled
--- ### Example
--- ```lua
--- function server.init()
--- 	SetLightEnabled(FindLight("main"), false)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetLightEnabled)
function SetLightEnabled(handle, enabled) end

--- This will only set the color tint of the light. Use SetLightIntensity for brightness.
--- Setting the light color will not affect the emissive color of a parent shape.
--- @param handle number -- Light handle
--- @param r number -- Red value
--- @param g number -- Green value
--- @param b number -- Blue value
--- ### Example
--- ```lua
--- function server.init()
--- 	--Set light color to yellow
--- 	SetLightColor(FindLight("main"), 1, 1, 0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetLightColor)
function SetLightColor(handle, r, g, b) end

--- If the shape is owned by a shape you most likely want to use
--- SetShapeEmissiveScale instead, which will affect both the emissiveness
--- of the shape and the brightness of the light at the same time.
--- @param handle number -- Light handle
--- @param intensity number -- Desired intensity of the light
--- ### Example
--- ```lua
--- function server.init()
--- 	--Pulsate light
--- 	SetLightIntensity(FindLight("main"), math.sin(GetTime())*0.5 + 1.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetLightIntensity)
function SetLightIntensity(handle, intensity) end

--- Lights that are owned by a dynamic shape are automatcially moved with that shape
--- @param handle number -- Light handle
--- @return TTransform transform -- World space light transform
--- ### Example
--- ```lua
--- local light = 0
--- function client.init()
--- 	light = FindLight("main")
--- 	local t = GetLightTransform(light)
--- 	DebugPrint(VecStr(t.pos))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetLightTransform)
function GetLightTransform(handle) end

--- @param handle number -- Light handle
--- @return number handle -- Shape handle or zero if not attached to shape
--- ### Example
--- ```lua
--- local light = 0
--- function client.init()
--- 	light = FindLight("main")
--- 	local shape = GetLightShape(light)
--- 	DebugPrint(shape)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetLightShape)
function GetLightShape(handle) end

--- @param handle number -- Light handle
--- @return boolean active -- True if light is currently emitting light
--- ### Example
--- ```lua
--- local light = 0
--- function client.init()
--- 	light = FindLight("main")
--- 	if IsLightActive(light) then
--- 		DebugPrint("Light is active")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsLightActive)
function IsLightActive(handle) end

--- @param handle number -- Light handle
--- @param point TVec -- World space point as vector
--- @return boolean affected -- Return true if point is in light cone and range
--- ### Example
--- ```lua
--- local light = 0
--- function client.init()
--- 	light = FindLight("main")
--- 	local point = Vec(0, 10, 0)
--- 	local affected = IsPointAffectedByLight(light, point)
--- 	DebugPrint(affected)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPointAffectedByLight)
function IsPointAffectedByLight(handle, point) end

--- Returns the handle of the player's flashlight. You can work with it as with an entity of the Light type.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- @return number handle -- Handle of the player's flashlight
--- ### Example
--- ```lua
--- function setFlashlightColor(playerId)
--- 	local flashlight = GetFlashlight(playerId)
--- 	SetProperty(flashlight, "color", Vec(0.5, 0, 1))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetFlashlight)
function GetFlashlight(playerId) end

--- Sets a new entity of the Light type as a flashlight.
--- @param handle number -- Handle of the light
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- local oldLight = 0
--- function server.tick()
--- 	... -- some code
--- 	-- in order not to lose the original flashlight, it is better to save it's handle
--- 	oldLight = GetFlashlight(playerId)
--- 	SetFlashlight(FindEntity("mylight", true), playerId)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetFlashlight)
function SetFlashlight(handle, playerId) end

