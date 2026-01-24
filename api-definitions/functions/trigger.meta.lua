--- @meta


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first trigger with specified tag or zero if not found
--- ### Example
--- ```lua
--- function server.init()
--- 	local goal = FindTrigger("goal")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindTrigger)
function FindTrigger(tag, global) end

--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all triggers with specified tag
--- ### Example
--- ```lua
--- function client.init()
--- 	--Find triggers tagged "toxic" in script scope
--- 	local triggers = FindTriggers("toxic")
--- 	for i=1, #triggers do
--- 		local trigger = triggers[i]
--- 		DebugPrint(trigger)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindTriggers)
function FindTriggers(tag, global) end

--- @param handle number -- Trigger handle
--- @return TTransform transform -- Current trigger transform in world space
--- ### Example
--- ```lua
--- function client.init()
--- 	local trigger = FindTrigger("toxic")
--- 	local t = GetTriggerTransform(trigger)
--- 	DebugPrint(t.pos)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTriggerTransform)
function GetTriggerTransform(handle) end

--- @param handle number -- Trigger handle
--- @param transform TTransform -- Desired trigger transform in world space
--- ### Example
--- ```lua
--- function server.init()
--- 	local trigger = FindTrigger("toxic")
--- 	local t = Transform(Vec(0, 1, 0), QuatEuler(0, 90, 0))
--- 	SetTriggerTransform(trigger, t)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetTriggerTransform)
function SetTriggerTransform(handle, transform) end

--- Return the lower and upper points in world space of the trigger axis aligned bounding box
--- @param handle number -- Trigger handle
--- @return TVec min -- Lower point of trigger bounds in world space
--- @return TVec max -- Upper point of trigger bounds in world space
--- ### Example
--- ```lua
--- function client.init()
--- 	local trigger = FindTrigger("toxic")
--- 	local mi, ma = GetTriggerBounds(trigger)
--- 	local list = QueryAabbShapes(mi, ma)
--- 	for i = 1, #list do
--- 		DebugPrint(list[i])
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTriggerBounds)
function GetTriggerBounds(handle) end

--- This function will only check the center point of the body
--- @param trigger number -- Trigger handle
--- @param body number -- Body handle
--- @return boolean inside -- True if body is in trigger volume
--- ### Example
--- ```lua
--- local trigger = 0
--- local body = 0
--- function client.init()
--- 	trigger = FindTrigger("toxic")
--- 	body = FindBody("body")
--- end
--- function client.tick()
--- 	if IsBodyInTrigger(trigger, body) then
--- 		DebugPrint("In trigger!")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsBodyInTrigger)
function IsBodyInTrigger(trigger, body) end

--- This function will only check origo of vehicle
--- @param trigger number -- Trigger handle
--- @param vehicle number -- Vehicle handle
--- @return boolean inside -- True if vehicle is in trigger volume
--- ### Example
--- ```lua
--- local trigger = 0
--- local vehicle = 0
--- function client.init()
--- 	trigger = FindTrigger("toxic")
--- 	vehicle = FindVehicle("vehicle")
--- end
--- function client.tick()
--- 	if IsVehicleInTrigger(trigger, vehicle) then
--- 		DebugPrint("In trigger!")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsVehicleInTrigger)
function IsVehicleInTrigger(trigger, vehicle) end

--- This function will only check the center point of the shape
--- @param trigger number -- Trigger handle
--- @param shape number -- Shape handle
--- @return boolean inside -- True if shape is in trigger volume
--- ### Example
--- ```lua
--- local trigger = 0
--- local shape = 0
--- function client.init()
--- 	trigger = FindTrigger("toxic")
--- 	shape = FindShape("shape")
--- end
--- function client.tick()
--- 	if IsShapeInTrigger(trigger, shape) then
--- 		DebugPrint("In trigger!")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsShapeInTrigger)
function IsShapeInTrigger(trigger, shape) end

--- @param trigger number -- Trigger handle
--- @param point TVec -- Word space point as vector
--- @return boolean inside -- True if point is in trigger volume
--- ### Example
--- ```lua
--- local trigger = 0
--- local point = {}
--- function client.init()
--- 	trigger = FindTrigger("toxic", true)
--- 	point = Vec(0, 0, 0)
--- end
--- function client.tick()
--- 	if IsPointInTrigger(trigger, point) then
--- 		DebugPrint("In trigger!")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPointInTrigger)
function IsPointInTrigger(trigger, point) end

--- Checks whether the point is within the scene boundaries.
--- If there are no boundaries on the scene, the function returns True.
--- @param point TVec -- Point
--- @return boolean value -- True if point is inside scene boundaries or if there are no boundaries
--- @return number dist -- Distance to the scene boundaries. Zero if there are no boundaries or if point is outside.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local p = Vec(1.5, 3, 2.5)
--- 	DebugWatch("In boundaries", IsPointInBoundaries(p))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPointInBoundaries)
function IsPointInBoundaries(point) end

--- This function will check if trigger is empty. If trigger contains any part of a body
--- it will return false and the highest point as second return value.
--- @param handle number -- Trigger handle
--- @param demolision? boolean -- If true, small debris and vehicles are ignored
--- @return boolean empty -- True if trigger is empty
--- @return TVec maxpoint -- World space point of highest point (largest Y coordinate) if not empty
--- ### Example
--- ```lua
--- local trigger = 0
--- function client.init()
--- 	trigger = FindTrigger("toxic")
--- end
--- function client.tick()
--- 	local empty, highPoint = IsTriggerEmpty(trigger)
--- 	if not empty then
--- 		--highPoint[2] is the tallest point in trigger
--- 		DebugPrint("Is not empty")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsTriggerEmpty)
function IsTriggerEmpty(handle, demolision) end

--- Get distance to the surface of trigger volume. Will return negative distance if inside.
--- @param trigger number -- Trigger handle
--- @param point TVec -- Word space point as vector
--- @return number distance -- Positive if point is outside, negative if inside
--- ### Example
--- ```lua
--- local trigger = 0
--- function client.init()
--- 	trigger = FindTrigger("toxic")
--- 	local p = Vec(0, 10, 0)
--- 	local dist = GetTriggerDistance(trigger, p)
--- 	DebugPrint(dist)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTriggerDistance)
function GetTriggerDistance(trigger, point) end

--- Return closest point in trigger volume. Will return the input point itself if inside trigger
--- or closest point on surface of trigger if outside.
--- @param trigger number -- Trigger handle
--- @param point TVec -- Word space point as vector
--- @return TVec closest -- Closest point in trigger as vector
--- ### Example
--- ```lua
--- local trigger = 0
--- function client.init()
--- 	trigger = FindTrigger("toxic")
--- 	local p = Vec(0, 10, 0)
--- 	local closest = GetTriggerClosestPoint(trigger, p)
--- 	DebugPrint(closest)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTriggerClosestPoint)
function GetTriggerClosestPoint(trigger, point) end

