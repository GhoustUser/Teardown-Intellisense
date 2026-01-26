--- @meta


--- ### CLIENT ONLY
--- Adds a marker on the map with the provided info.


--- ### Example
--- ```lua
--- function client.tick()
--- 	AddMapMarker(1, "bonusTarget", "Bonus Target", "One of a kind", Vec(30, 40, 50), Vec(1,0,0), "MOD/gfx/bonus_info.png", "MOD/gfx/bonus_icon.png")
--- end
--- ```
--- @param id number -- An id to identify the marker, typically player ID or body ID.
--- @param tag string -- A tag to help distinguish markers.
--- @param name string -- Name of the marker.
--- @param category string -- Used to group markers together in map target list.
--- @param showLabelOnMap boolean -- name label will be shown on map if true
--- @param info string -- Additional information about the marker, displayed when selected.
--- @param pos TVec -- The world position of the marker.
--- @param color TVec -- The color of the marker, as a Vec table (e.g. Vec(1, 0, 0) for red)
--- @param infoImage? string -- Path to the image to be displayed in the info section.
--- @param dotIcon? string -- Path to the image used to represent the marker on map.
--- [View Documentation](https://teardowngame.com/experimental/api.html#AddMapMarker)
function AddMapMarker(id, tag, name, category, showLabelOnMap, info, pos, color, infoImage, dotIcon) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- function client.tick()
--- 	AddMapMarker(1, "bonusTarget", "Bonus Target", "One of a kind", Vec(30, 40, 50), Vec(1,0,0), "MOD/gfx/bonus_info.png", "MOD/gfx/bonus_icon.png")
--- 	local id, tag = SelectedMapMarker()
--- 	if id == 1 and tag == "bonusTarget" then
--- 		DebugPrint("You selected the Bonus Target on the map!")
--- 	end
--- end
--- ```
--- @return number id -- id of map marker that was selected this tick.
--- @return string tag -- the corresponding tag.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SelectedMapMarker)
function SelectedMapMarker() end

--- ### SERVER ONLY
--- Fire projectile. Type can be one of "bullet", "rocket", "gun" or "shotgun".
--- For backwards compatilbility, type also accept a number, where 1 is same as "rocket" and anything else "bullet"
--- Note that this function will only spawn the projectile, not make any sound.
--- ### Example
--- ```lua
--- function server.tick()
--- 	Shoot(Vec(0, 10, 0), Vec(0, -1, 0), "shotgun")
--- end
--- ```
--- @param origin TVec -- Origin in world space as vector
--- @param direction TVec -- Unit length direction as world space vector
--- @param type? string -- Shot type, see description, default is "bullet"
--- @param strength? number -- Strength scaling, default is 1.0
--- @param maxDist? number -- Maximum distance, default is 100.0
--- @param playerId? number -- Instigating player. Can be skipped for non-player shots (helicopters etc.)
--- [View Documentation](https://teardowngame.com/experimental/api.html#Shoot)
function Shoot(origin, direction, type, strength, maxDist, playerId) end

--- ### SERVER ONLY
--- Tint the color of objects within radius to either black or yellow.
--- ### Example
--- ```lua
--- function server.tick()
--- 	Paint(Vec(0, 2, 0), 5.0, "spraycan")
--- end
--- ```
--- @param origin TVec -- Origin in world space as vector
--- @param radius number -- Affected radius, in range 0.0 to 5.0
--- @param type? string -- Paint type. Can be "explosion" or "spraycan". Default is spraycan.
--- @param probability? number -- Dithering probability between zero and one, default is 1.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#Paint)
function Paint(origin, radius, type, probability) end

--- ### SERVER ONLY
--- Tint the color of objects within radius to custom RGBA color.
--- ### Example
--- ```lua
--- function server.tick()
--- 	PaintRGBA(Vec(0, 5, 0), 5.5, 1.0, 0.0, 0.0)
--- end
--- ```
--- @param origin TVec -- Origin in world space as vector
--- @param radius number -- Affected radius, in range 0.0 to 5.0
--- @param red number -- red color value, in range 0.0 to 1.0
--- @param green number -- green color value, in range 0.0 to 1.0
--- @param blue number -- blue color value, in range 0.0 to 1.0
--- @param alpha? number -- alpha channel value, in range 0.0 to 1.0
--- @param probability? number -- Dithering probability between zero and one, default is 1.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#PaintRGBA)
function PaintRGBA(origin, radius, red, green, blue, alpha, probability) end

--- ### SERVER ONLY
--- Make a hole in the environment. Radius is given in meters.
--- Soft materials: glass, foliage, dirt, wood, plaster and plastic.
--- Medium materials: concrete, brick and weak metal.
--- Hard materials: hard metal and hard masonry.
--- ### Example
--- ```lua
--- function server.init()
--- 	MakeHole(Vec(0, 0, 0), 5.0, 1.0)
--- end
--- ```
--- @param position TVec -- Hole center point
--- @param r0 number -- Hole radius for soft materials
--- @param r1? number -- Hole radius for medium materials. May not be bigger than r0. Default zero.
--- @param r2? number -- Hole radius for hard materials. May not be bigger than r1. Default zero.
--- @param silent? boolean -- Make hole without playing any break sounds.
--- @return number count -- Number of voxels that was cut out. This will be zero if there were no changes to any shape.
--- [View Documentation](https://teardowngame.com/experimental/api.html#MakeHole)
function MakeHole(position, r0, r1, r2, silent) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function server.init()
--- 	Explosion(Vec(0, 5, 0), 1)
--- end
--- ```
--- @param pos TVec -- Position in world space as vector
--- @param size number -- Explosion size from 0.5 to 4.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#Explosion)
function Explosion(pos, size) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function server.tick()
--- 	SpawnFire(Vec(0, 2, 0))
--- end
--- ```
--- @param pos TVec -- Position in world space as vector
--- [View Documentation](https://teardowngame.com/experimental/api.html#SpawnFire)
function SpawnFire(pos) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local c = GetFireCount()
--- 	DebugPrint("Fire count " .. c)
--- end
--- ```
--- @return number count -- Number of active fires in level
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetFireCount)
function GetFireCount() end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local hit, pos = QueryClosestFire(GetPlayerTransform().pos, 5.0)
--- 	if hit then
--- 		--There is a fire within 5 meters to the player. Mark it with a debug cross.
--- 		DebugCross(pos)
--- 	end
--- end
--- ```
--- @param origin TVec -- World space position as vector
--- @param maxDist number -- Maximum search distance
--- @return boolean hit -- A fire was found within search distance
--- @return TVec pos -- Position of closest fire
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryClosestFire)
function QueryClosestFire(origin, maxDist) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local count = QueryAabbFireCount(Vec(0,0,0), Vec(10,10,10))
--- 	DebugPrint(count)
--- end
--- ```
--- @param min TVec -- Aabb minimum point
--- @param max TVec -- Aabb maximum point
--- @return number count -- Number of active fires in bounding box
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryAabbFireCount)
function QueryAabbFireCount(min, max) end

--- ### SERVER ONLY
--- ### Example
--- ```lua
--- function server.tick()
--- 	local removedCount= RemoveAabbFires(Vec(0,0,0), Vec(10,10,10))
--- 	DebugPrint(removedCount)
--- end
--- ```
--- @param min TVec -- Aabb minimum point
--- @param max TVec -- Aabb maximum point
--- @return number count -- Number of fires removed
--- [View Documentation](https://teardowngame.com/experimental/api.html#RemoveAabbFires)
function RemoveAabbFires(min, max) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- function client.tick()
--- 	local t = GetCameraTransform()
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- @return TTransform transform -- Current camera transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetCameraTransform)
function GetCameraTransform() end

--- ### CLIENT ONLY
--- Override current camera transform for this frame. Call continuously to keep overriding.
--- When transform of some shape or body used to calculate camera transform, consider use of AttachCameraTo,
--- because you might be using transform from previous physics update
--- (that was on previous frame or even earlier depending on fps and timescale).
--- ### Example
--- ```lua
--- function client.tick()
--- 	SetCameraTransform(Transform(Vec(0, 10, 0), QuatEuler(0, 90, 0)))
--- end
--- ```
--- @param transform TTransform -- Desired camera transform
--- @param fov? number -- Optional horizontal field of view in degrees (default: 90)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetCameraTransform)
function SetCameraTransform(transform, fov) end

--- ### CLIENT ONLY
--- Use this function to switch to first-person view, overriding the player's selected third-person view.
--- This is particularly useful for scenarios like looking through a camera viewfinder or a rifle scope.
--- Call the function continuously to maintain the override.
--- ### Example
--- ```lua
--- function client.tick()
--- 	if useViewFinder then
--- 		RequestFirstPerson(true)
--- 	end
--- end
--- function client.draw()
--- 	if useViewFinder and !GetBool("game.thirdperson") then
--- 		-- Draw view finder overlay
--- 	end
--- end
--- ```
--- @param transition boolean -- Use transition
--- [View Documentation](https://teardowngame.com/experimental/api.html#RequestFirstPerson)
function RequestFirstPerson(transition) end

--- ### CLIENT ONLY
--- Use this function to switch to third-person view, overriding the player's selected first-person view.
--- Call the function continuously to maintain the override.
--- ### Example
--- ```lua
--- function client.tick()
--- 	if useThirdPerson then
--- 		RequestThirdPerson(true)
--- 	end
--- end
--- ```
--- @param transition boolean -- Use transition
--- [View Documentation](https://teardowngame.com/experimental/api.html#RequestThirdPerson)
function RequestThirdPerson(transition) end

--- ### CLIENT ONLY
--- Call this function continously to apply a camera offset. Can be used for camera effects
--- such as shake and wobble.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local tPosX = Transform(Vec(math.sin(GetTime()*3.0) * 0.2, 0, 0))
--- 	local tPosY = Transform(Vec(0, math.cos(GetTime()*3.0) * 0.2, 0), QuatAxisAngle(Vec(0, 0, 0)))
--- 	SetCameraOffsetTransform(tPosX, true)
--- 	SetCameraOffsetTransform(tPosY, true)
--- end
--- ```
--- @param transform TTransform -- Desired camera offset transform
--- @param stackable? boolean -- True if camera offset should summ up with multiple calls per tick
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetCameraOffsetTransform)
function SetCameraOffsetTransform(transform, stackable) end

--- ### CLIENT ONLY
--- Attach current camera transform for this frame to body or shape. Call continuously to keep overriding.
--- In tick function we have coordinates of bodies and shapes that are not yet updated by physics,
--- that's why camera can not be in sync with it using SetCameraTransform,
--- instead use this function and SetCameraOffsetTransform to place camera around any body or shape without lag.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = GetPlayerVehicle()
--- 	if vehicle ~= 0 then
--- 		AttachCameraTo(GetVehicleBody(vehicle))
--- 		SetCameraOffsetTransform(Transform(Vec(1, 2, 3)))
--- 	end
--- end
--- ```
--- @param handle number -- Body or shape handle
--- @param ignoreRotation? boolean -- True to ignore rotation and use position only, false to use full transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#AttachCameraTo)
function AttachCameraTo(handle, ignoreRotation) end

--- ### CLIENT ONLY
--- treated as pivots when clipping
--- body's shapes which is used to calculate clipping parameters
--- (default: -1)
--- Enforce camera clipping for this frame and mark the given body as a
--- pivot for clipping. Call continuously to keep overriding.
--- ### Example
--- ```lua
--- local body_1 = 0
--- local body_2 = 0
--- function client.init()
--- 	body_1 = FindBody("body_1")
--- 	body_2 = FindBody("body_2")
--- end
--- function client.tick()
--- 	SetPivotClipBody(body_1, 0) -- this overload should be called once and
--- 	-- only once per frame to take effect
--- 	SetPivotClipBody(body_2)
--- end
--- ```
--- @param bodyHandle number -- Handle of a body, shapes of which should be
--- @param mainShapeIdx number -- Optional index of a shape among the given
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPivotClipBody)
function SetPivotClipBody(bodyHandle, mainShapeIdx) end

--- ### CLIENT ONLY
--- Shakes the player camera
--- ### Example
--- ```lua
--- function client.tick()
--- 	ShakeCamera(0.5)
--- end
--- ```
--- @param strength number -- Normalized strength of shaking
--- [View Documentation](https://teardowngame.com/experimental/api.html#ShakeCamera)
function ShakeCamera(strength) end

--- ### CLIENT ONLY
--- Override field of view for the next frame for all camera modes, except when explicitly set in SetCameraTransform
--- ### Example
--- ```lua
--- function client.tick()
--- 	SetCameraFov(60)
--- end
--- ```
--- @param degrees number -- Horizontal field of view in degrees (10-170)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetCameraFov)
function SetCameraFov(degrees) end

--- ### CLIENT ONLY
--- Override depth of field for the next frame for all camera modes. Depth of field will be used even if turned off in options.
--- ### Example
--- ```lua
--- function client.tick()
--- 	--Set depth of field to 10 meters
--- 	SetCameraDof(10)
--- end
--- ```
--- @param distance number -- Depth of field distance
--- @param amount? number -- Optional amount of blur (default 1.0)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetCameraDof)
function SetCameraDof(distance, amount) end

--- ### CLIENT ONLY
--- Must be called every frame that one would like to alter this effect. Client-side only
--- ### Example
--- ```lua
--- function client.tick()
--- 	-- Don't show the blurry vision until the player's health drops below 0.4
--- 	SetLowHealthBlurThreshold(0.4)
--- end
--- ```
--- @param health number -- health value where anything lower results in blurred vision
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetLowHealthBlurThreshold)
function SetLowHealthBlurThreshold(health) end

--- Add a temporary point light to the world for this frame. Call continuously
--- for a steady light.
--- ### Example
--- ```lua
--- function client.tick()
--- 	--Pulsating, yellow light above world origo
--- 	local intensity = 3 + math.sin(GetTime())
--- 	PointLight(Vec(0, 5, 0), 1, 1, 0, intensity)
--- end
--- ```
--- @param pos TVec -- World space light position
--- @param r number -- Red
--- @param g number -- Green
--- @param b number -- Blue
--- @param intensity? number -- Intensity. Default is 1.0.
--- [View Documentation](https://teardowngame.com/experimental/api.html#PointLight)
function PointLight(pos, r, g, b, intensity) end

--- ### SERVER ONLY
--- Experimental. Scale time in order to make a slow-motion or acceleration effect. Audio will also be affected.
--- (v1.4 and below: this function will affect physics behavior and is not intended for gameplay purposes.)
--- Starting from v1.5 this function does not affect physics behavior and rely on rendering interpolation.
--- Scaling time up may decrease performance, and is not recommended for gameplay purposes.
--- Calling this function will change time scale for the next frame only.
--- Call every frame from tick function to get steady slow-motion.
--- ### Example
--- ```lua
--- function server.tick()
--- 	--Slow down time when holding down a key
--- 	if InputDown('t', hostPlayerId) then
--- 		SetTimeScale(0.2)
--- 	end
--- end
--- ```
--- @param scale number -- Time scale 0.0 to 2.0
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetTimeScale)
function SetTimeScale(scale) end

--- ### SERVER ONLY
--- Reset the environment properties to default. This is often useful before
--- setting up a custom environment.
--- ### Example
--- ```lua
--- function server.init()
--- 	SetEnvironmentDefault()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetEnvironmentDefault)
function SetEnvironmentDefault() end

--- ### SERVER ONLY
--- This function is used for manipulating the environment properties. The available properties are
--- exactly the same as in the editor, except for "snowonground" which is not currently supported.
--- ### Example
--- ```lua
--- function server.init()
--- 	SetEnvironmentDefault()
--- 	SetEnvironmentProperty("skybox", "cloudy.dds")
--- 	SetEnvironmentProperty("rain", 0.7)
--- 	SetEnvironmentProperty("fogcolor", 0.5, 0.5, 0.8)
--- 	SetEnvironmentProperty("nightlight", false)
--- end
--- ```
--- @param name string -- Property name
--- @param value0 any -- Property value (type depends on property)
--- @param value1? any -- Extra property value (only some properties)
--- @param value2? any -- Extra property value (only some properties)
--- @param value3? any -- Extra property value (only some properties)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetEnvironmentProperty)
function SetEnvironmentProperty(name, value0, value1, value2, value3) end

--- This function is used for querying the current environment properties. The available properties are
--- exactly the same as in the editor.
--- ### Example
--- ```lua
--- function client.init()
--- 	local skyboxPath = GetEnvironmentProperty("skybox")
--- 	local rainValue = GetEnvironmentProperty("rain")
--- 	local r,g,b = GetEnvironmentProperty("fogcolor")
--- 	local enabled = GetEnvironmentProperty("nightlight")
--- 	DebugPrint(skyboxPath)
--- 	DebugPrint(rainValue)
--- 	DebugPrint(r .. " " .. g .. " " .. b)
--- 	DebugPrint(enabled)
--- end
--- ```
--- @param name string -- Property name
--- @return any value0 -- Property value (type depends on property)
--- @return any value1 -- Property value (only some properties)
--- @return any value2 -- Property value (only some properties)
--- @return any value3 -- Property value (only some properties)
--- @return any value4 -- Property value (only some properties)
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEnvironmentProperty)
function GetEnvironmentProperty(name) end

--- Reset the post processing properties to default.
--- ### Example
--- ```lua
--- function client.tick()
--- 	SetPostProcessingProperty("saturation", 0.4)
--- 	SetPostProcessingProperty("colorbalance", 1.3, 1.0, 0.7)
--- 	SetPostProcessingDefault()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPostProcessingDefault)
function SetPostProcessingDefault() end

--- This function is used for manipulating the post processing properties. The available properties are
--- exactly the same as in the editor.
--- ### Example
--- ```lua
--- --Sepia post processing
--- function client.tick()
--- 	SetPostProcessingProperty("saturation", 0.4)
--- 	SetPostProcessingProperty("colorbalance", 1.3, 1.0, 0.7)
--- end
--- ```
--- @param name string -- Property name
--- @param value0 number -- Property value
--- @param value1? number -- Extra property value (only some properties)
--- @param value2? number -- Extra property value (only some properties)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetPostProcessingProperty)
function SetPostProcessingProperty(name, value0, value1, value2) end

--- This function is used for querying the current post processing properties.
--- The available properties are exactly the same as in the editor.
--- ### Example
--- ```lua
--- function client.tick()
--- 	SetPostProcessingProperty("saturation", 0.4)
--- 	SetPostProcessingProperty("colorbalance", 1.3, 1.0, 0.7)
--- 	local saturation = GetPostProcessingProperty("saturation")
--- 	local r,g,b = GetPostProcessingProperty("colorbalance")
--- 	DebugPrint("saturation " .. saturation)
--- 	DebugPrint("colorbalance " .. r .. " " .. g .. " " .. b)
--- end
--- ```
--- @param name string -- Property name
--- @return number value0 -- Property value
--- @return number value1 -- Property value (only some properties)
--- @return number value2 -- Property value (only some properties)
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPostProcessingProperty)
function GetPostProcessingProperty(name) end

--- Draw a 3D line. In contrast to DebugLine, it will not show behind objects. Default color is white.
--- ### Example
--- ```lua
--- function server.tick()
--- 	--Draw white debug line
--- 	DrawLine(Vec(0, 0, 0), Vec(-10, 5, -10))
--- 	--Draw red debug line
--- 	DrawLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
--- end
--- -- Or
--- function client.tick()
--- 	--Draw white debug line
--- 	DrawLine(Vec(0, 0, 0), Vec(-10, 5, -10))
--- 	--Draw red debug line
--- 	DrawLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
--- end
--- ```
--- @param p0 TVec -- World space point as vector
--- @param p1 TVec -- World space point as vector
--- @param r? number -- Red
--- @param g? number -- Green
--- @param b? number -- Blue
--- @param a? number -- Alpha
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawLine)
function DrawLine(p0, p1, r, g, b, a) end

--- Draw a 3D debug overlay line in the world. Default color is white.
--- ### Example
--- ```lua
--- function server.tick()
--- 	--Draw white debug line
--- 	DebugLine(Vec(0, 0, 0), Vec(-10, 5, -10))
--- 	--Draw red debug line
--- 	DebugLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
--- end
--- -- Or
--- function client.tick()
--- 	--Draw white debug line
--- 	DebugLine(Vec(0, 0, 0), Vec(-10, 5, -10))
--- 	--Draw red debug line
--- 	DebugLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
--- end
--- ```
--- @param p0 TVec -- World space point as vector
--- @param p1 TVec -- World space point as vector
--- @param r? number -- Red
--- @param g? number -- Green
--- @param b? number -- Blue
--- @param a? number -- Alpha
--- [View Documentation](https://teardowngame.com/experimental/api.html#DebugLine)
function DebugLine(p0, p1, r, g, b, a) end

--- Draw a debug cross in the world to highlight a location. Default color is white.
--- ### Example
--- ```lua
--- function server.tick()
--- 	DebugCross(Vec(10, 5, 5))
--- end
--- -- Or
--- function client.tick()
--- 	DebugCross(Vec(10, 5, 5))
--- end
--- ```
--- @param p0 TVec -- World space point as vector
--- @param r? number -- Red
--- @param g? number -- Green
--- @param b? number -- Blue
--- @param a? number -- Alpha
--- [View Documentation](https://teardowngame.com/experimental/api.html#DebugCross)
function DebugCross(p0, r, g, b, a) end

--- Draw the axis of the transform
--- ### Example
--- ```lua
--- function server.tick()
--- 	DebugTransform(GetPlayerCameraTransform(), 0.5)
--- end
--- -- Or
--- function client.tick()
--- 	DebugTransform(GetPlayerCameraTransform(), 0.5)
--- end
--- ```
--- @param transform TTransform -- The transform
--- @param scale? number -- Length of the axis
--- [View Documentation](https://teardowngame.com/experimental/api.html#DebugTransform)
function DebugTransform(transform, scale) end

--- Show a named valued on screen for debug purposes.
--- Up to 32 values can be shown simultaneously. Values updated the current
--- frame are drawn opaque. Old values are drawn transparent in white.
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugWatch("Player camera transform", GetPlayerCameraTransform())
--- 	local anyTable = {
--- 		"teardown",
--- 		{
--- 			name = "Alex",
--- 			age = 25,
--- 			child = { name = "Lena" }
--- 		},
--- 		nil,
--- 		version = "1.6.0",
--- 		true
--- 	}
--- 	DebugWatch("table", anyTable);
--- end
--- ```
--- @param name string -- Name
--- @param value any -- Value
--- @param lineWrapping? boolean -- True if you need to wrap Table lines. Works only with tables.
--- [View Documentation](https://teardowngame.com/experimental/api.html#DebugWatch)
function DebugWatch(name, value, lineWrapping) end

--- Display message on screen. The last 20 lines are displayed.
--- The function will also recognize tables and convert them to strings automatically.
--- ### Example
--- ```lua
--- function client.init()
--- 	DebugPrint("time")
--- 	DebugPrint(GetPlayerCameraTransform())
--- 	local anyTable = {
--- 		"teardown",
--- 		{
--- 			name = "Alex",
--- 			age = 25,
--- 			child = { name = "Lena" }
--- 		},
--- 		nil,
--- 		version = "1.6.0",
--- 		true,
--- 	}
--- 	DebugPrint(anyTable)
--- end
--- ```
--- @param message string -- Message to display
--- @param lineWrapping? boolean -- True if you need to wrap Table lines. Works only with tables.
--- [View Documentation](https://teardowngame.com/experimental/api.html#DebugPrint)
function DebugPrint(message, lineWrapping) end

--- ### Example
--- ```lua
--- function onLangauageChanged()
--- 	DebugPrint("langauageChanged")
--- end
--- function client.init()
--- 	RegisterListenerTo("LanguageChanged", "onLangauageChanged")
--- 	TriggerEvent("LanguageChanged")
--- end
--- ```
--- @param eventName string -- Event name
--- @param listenerFunction string -- Listener function name
--- [View Documentation](https://teardowngame.com/experimental/api.html#RegisterListenerTo)
function RegisterListenerTo(eventName, listenerFunction) end

--- ### Example
--- ```lua
--- function onLangauageChanged()
--- 	DebugPrint("langauageChanged")
--- end
--- function client.init()
--- 	RegisterListenerTo("LanguageChanged", "onLangauageChanged")
--- 	UnregisterListener("LanguageChanged", "onLangauageChanged")
--- 	TriggerEvent("LanguageChanged")
--- end
--- ```
--- @param eventName string -- Event name
--- @param listenerFunction string -- Listener function name
--- [View Documentation](https://teardowngame.com/experimental/api.html#UnregisterListener)
function UnregisterListener(eventName, listenerFunction) end

--- ### Example
--- ```lua
--- function onLangauageChanged()
--- 	DebugPrint("langauageChanged")
--- end
--- function client.init()
--- 	RegisterListenerTo("LanguageChanged", "onLangauageChanged")
--- 	UnregisterListener("LanguageChanged", "onLangauageChanged")
--- 	TriggerEvent("LanguageChanged")
--- end
--- ```
--- @param eventName string -- Event name
--- @param args? string -- Event parameters
--- [View Documentation](https://teardowngame.com/experimental/api.html#TriggerEvent)
function TriggerEvent(eventName, args) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- -- Rumble with gun Haptic effect
--- function client.init()
--- 	haptic_effect = LoadHaptic("haptic/gun_fire.xml")
--- end
--- function client.tick()
--- 	if trigHaptic then
--- 		PlayHaptic(haptic_effect, 1)
--- 	end
--- end
--- ```
--- @param filepath string -- Path to Haptic effect to play
--- @return string handle -- Haptic effect handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#LoadHaptic)
function LoadHaptic(filepath) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- -- Rumble with gun Haptic effect
--- function client.init()
--- 	haptic_effect = CreateHaptic(1, 1, 0, 0)
--- end
--- function client.tick()
--- 	if trigHaptic then
--- 		PlayHaptic(haptic_effect, 1)
--- 	end
--- end
--- ```
--- @param leftMotorRumble number -- Amount of rumble for left motor
--- @param rightMotorRumble number -- Amount of rumble for right motor
--- @param leftTriggerRumble number -- Amount of rumble for left trigger
--- @param rightTriggerRumble number -- Amount of rumble for right trigger
--- @return string handle -- Haptic effect handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#CreateHaptic)
function CreateHaptic(leftMotorRumble, rightMotorRumble, leftTriggerRumble, rightTriggerRumble) end

--- ### CLIENT ONLY
--- If Haptic already playing, restarts it.
--- ### Example
--- ```lua
--- -- Rumble with gun Haptic effect
--- function client.init()
--- 	haptic_effect = LoadHaptic("haptic/gun_fire.xml")
--- end
--- function client.tick()
--- 	if trigHaptic then
--- 		PlayHaptic(haptic_effect, 1)
--- 	end
--- end
--- ```
--- @param handle string -- Handle of haptic effect
--- @param amplitude number -- Amplidute used for calculation of Haptic effect.
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayHaptic)
function PlayHaptic(handle, amplitude) end

--- ### CLIENT ONLY
--- If Haptic already playing, restarts it.
--- ### Example
--- ```lua
--- -- Rumble with gun Haptic effect
--- local haptic_effect
--- function client.init()
--- 	haptic_effect = LoadHaptic("haptic/gun_fire.xml")
--- end
--- function client.tick()
--- 	if InputPressed("interact") then
--- 		PlayHapticDirectional(haptic_effect, Vec(-1, 0, 0), 1)
--- 	end
--- end
--- ```
--- @param handle string -- Handle of haptic effect
--- @param direction TVec -- Direction in which effect must be played
--- @param amplitude number -- Amplidute used for calculation of Haptic effect.
--- [View Documentation](https://teardowngame.com/experimental/api.html#PlayHapticDirectional)
function PlayHapticDirectional(handle, direction, amplitude) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- -- Rumble infinitely
--- local haptic_effect
--- function client.init()
--- 	haptic_effect = LoadHaptic("haptic/gun_fire.xml")
--- end
--- function client.tick()
--- 	if not HapticIsPlaying(haptic_effect) then
--- 		PlayHaptic(haptic_effect, 1)
--- 	end
--- end
--- ```
--- @param handle string -- Handle of haptic effect
--- @return boolean flag -- is current Haptic playing or not
--- [View Documentation](https://teardowngame.com/experimental/api.html#HapticIsPlaying)
function HapticIsPlaying(handle) end

--- ### CLIENT ONLY
--- Register haptic as a "Tool haptic" for custom tools.
--- "Tool haptic" will be played on repeat while this tool is active.
--- Also it can be used for Active Triggers of DualSense controller
--- ### Example
--- ```lua
--- function client.init()
--- 	RegisterTool("minigun", "loc@MINIGUN", "MOD/vox/minigun.vox")
--- 	toolHaptic = LoadHaptic("MOD/haptic/tool.xml")
--- 	SetToolHaptic("minigun", toolHaptic)
--- end
--- ```
--- @param id string -- Tool unique identifier
--- @param handle string -- Handle of haptic effect
--- @param amplitude? number -- Amplitude multiplier. Default (1.0)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetToolHaptic)
function SetToolHaptic(id, handle, amplitude) end

--- ### CLIENT ONLY
--- ### Example
--- ```lua
--- -- Rumble infinitely
--- local haptic_effect
--- function client.init()
--- 	haptic_effect = LoadHaptic("haptic/gun_fire.xml")
--- end
--- function client.tick()
--- 	if InputDown("interact") then
--- 		StopHaptic(haptic_effect)
--- 	elseif not HapticIsPlaying(haptic_effect) then
--- 		PlayHaptic(haptic_effect, 1)
--- 	end
--- end
--- ```
--- @param handle string -- Handle of haptic effect
--- [View Documentation](https://teardowngame.com/experimental/api.html#StopHaptic)
function StopHaptic(handle) end

--- ### SERVER ONLY
--- Adds heat to shape. It works similar to blowtorch.
--- As soon as the heat of the voxel reaches a critical value, it destroys and can ignite the surrounding voxels.
--- ### Example
--- ```lua
--- function server.tick(dt)
--- 	if InputDown("usetool") then
--- 		local playerCameraTransform = GetPlayerCameraTransform()
--- 		local dir = TransformToParentVec(playerCameraTransform, Vec(0, 0, -1))
--- 		-- Cast ray out of player camera and add heat to shape if we can find one
--- 		local hit, dist, normal, shape = QueryRaycast(playerCameraTransform.pos, dir, 50)
--- 		if hit then
--- 			local hitPos = VecAdd(playerCameraTransform.pos, VecScale(dir, dist))
--- 			AddHeat(shape, hitPos, 2 * dt)
--- 		end
--- 		DrawLine(VecAdd(playerCameraTransform.pos, Vec(0.5, 0, 0)), VecAdd(playerCameraTransform.pos, VecScale(dir, dist)), 1, 0, 0, 1)
--- 	end
--- end
--- ```
--- @param shape number -- Shape handle
--- @param pos TVec -- World space point as vector
--- @param amount number -- amount of heat
--- [View Documentation](https://teardowngame.com/experimental/api.html#AddHeat)
function AddHeat(shape, pos, amount) end

--- Returns the area of the boundary if present, otherwise the xz-area of the world body aabb.
--- ### Example
--- ```lua
--- function GenerateRandomPointInLevel()
--- 	aabbMin, aabbMax = GetBoundaryBounds()
--- 	local x = GetRandomFloat(aabbMin[1], aabbMax[1])
--- 	local z = GetRandomFloat(aabbMin[3], aabbMax[3])
--- 	return x,z
--- end
--- ```
--- @return number area -- Number representing the area of the boundary.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoundaryArea)
function GetBoundaryArea() end

--- return the aabb bounds for the boundary if present, otherwise the boundary for the world body.
--- ### Example
--- ```lua
--- function GenerateRandomPointInLevel()
--- 	aabbMin, aabbMax = GetBoundaryBounds()
--- 	local x = GetRandomFloat(aabbMin[1], aabbMax[1])
--- 	local z = GetRandomFloat(aabbMin[3], aabbMax[3])
--- 	return x,z
--- end
--- ```
--- @return TVec min -- Vector representing the AABB lower bound
--- @return TVec max -- Vector representing the AABB upper bound
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoundaryBounds)
function GetBoundaryBounds() end

--- Returns the gravity value on the scene.
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugPrint(VecStr(GetGravity()))
--- end
--- ```
--- @return TVec vector -- Gravity vector
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetGravity)
function GetGravity() end

--- ### SERVER ONLY
--- Sets the gravity value on the scene.
--- When the scene restarts, it resets to the default value (0, -10, 0).
--- ### Example
--- ```lua
--- local isMoonGravityEnabled = false
--- function server.tick()
--- 	if InputPressed("g", hostPlayerId) then
--- 		isMoonGravityEnabled = not isMoonGravityEnabled
--- 		if isMoonGravityEnabled then
--- 			SetGravity(Vec(0, -1.6, 0))
--- 		else
--- 			SetGravity(Vec(0, -10.0, 0))
--- 		end
--- 	end
--- end
--- ```
--- @param vec TVec -- Gravity vector
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetGravity)
function SetGravity(vec) end

--- Returns the fps value based on general game timestep.
--- It doesn't depend on whether it is called from tick or update.
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugWatch("fps", GetFps())
--- end
--- ```
--- @return number fps -- Frames per second
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetFps)
function GetFps() end

