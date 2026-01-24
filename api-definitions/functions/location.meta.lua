--- @meta


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first location with specified tag or zero if not found
--- ### Example
--- ```lua
--- local loc = 0
--- function client.init()
--- 	loc = FindLocation("loc1")
--- end
--- function client.tick()
--- 	DebugCross(GetLocationTransform(loc).pos)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindLocation)
function FindLocation(tag, global) end

--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all locations with specified tag
--- ### Example
--- ```lua
--- local locations
--- function client.init()
--- 	locations = FindLocations("loc1")
--- 	for i=1, #locations do
--- 		local loc = locations[i]
--- 		DebugPrint(DebugPrint(loc))
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindLocations)
function FindLocations(tag, global) end

--- @param handle number -- Location handle
--- @return TTransform transform -- Transform of the location
--- ### Example
--- ```lua
--- local location = 0
--- function client.init()
--- 	location = FindLocation("loc1")
--- 	DebugPrint(VecStr(GetLocationTransform(location).pos))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetLocationTransform)
function GetLocationTransform(handle) end

