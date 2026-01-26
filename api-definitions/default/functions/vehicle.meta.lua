--- @meta


--- ### Example
--- ```lua
--- function client.init()
--- 	local vehicle = FindVehicle("mycar")
--- end
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first vehicle with specified tag or zero if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindVehicle)
function FindVehicle(tag, global) end

--- ### Example
--- ```lua
--- function client.init()
--- 	--Find all vehicles in level tagged "boat"
--- 	local boats = FindVehicles("boat")
--- 	for i=1, #boats do
--- 		local boat = boats[i]
--- 		DebugPrint(boat)
--- 	end
--- end
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all vehicles with specified tag
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindVehicles)
function FindVehicles(tag, global) end

--- ### Example
--- ```lua
--- function client.init()
--- 	local vehicle = FindVehicle("vehicle")
--- 	local t = GetVehicleTransform(vehicle)
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return TTransform transform -- Transform of vehicle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleTransform)
function GetVehicleTransform(vehicle) end

--- Returns the exhausts transforms in local space of the vehicle.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = FindVehicle("car", true)
--- 	local t = GetVehicleExhaustTransforms(vehicle)
--- 	for i = 1, #t do
--- 		DebugWatch(tostring(i), t[i])
--- 	end
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return table transforms -- Transforms of vehicle exhausts
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleExhaustTransforms)
function GetVehicleExhaustTransforms(vehicle) end

--- Returns the vitals transforms in local space of the vehicle.
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = FindVehicle("car", true)
--- 	local t = GetVehicleVitalTransforms(vehicle)
--- 	for i = 1, #t do
--- 		DebugWatch(tostring(i), t[i])
--- 	end
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return table transforms -- Transforms of vehicle vitals
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleVitalTransforms)
function GetVehicleVitalTransforms(vehicle) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = FindVehicle("car", true)
--- 	local t = GetVehicleBodies(vehicle)
--- 	for i = 1, #t do
--- 		DebugWatch(tostring(i), t[i])
--- 	end
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return table transforms -- Vehicle bodies handles
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleBodies)
function GetVehicleBodies(vehicle) end

--- ### Example
--- ```lua
--- function client.init()
--- 	local vehicle = FindVehicle("vehicle")
--- 	local body = GetVehicleBody(vehicle)
--- 	if IsBodyBroken(body) then
--- 		DebugPrint("Is broken")
--- 	end
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return number body -- Main body of vehicle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleBody)
function GetVehicleBody(vehicle) end

--- ### Example
--- ```lua
--- function client.init()
--- 	local vehicle = FindVehicle("vehicle")
--- 	local health = GetVehicleHealth(vehicle)
--- 	DebugPrint(health)
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return number health -- Vehicle health (zero to one)
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleHealth)
function GetVehicleHealth(vehicle) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local params = GetVehicleParams(FindVehicle("car", true))
--- 	for key, value in pairs(params) do
--- 		DebugWatch(key, value)
--- 	end
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return table params -- Vehicle params
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleParams)
function GetVehicleParams(vehicle) end

--- Available parameters: spring, damping, topspeed, acceleration, strength, antispin, antiroll, difflock, steerassist, friction
--- ### Example
--- ```lua
--- function server.init()
--- 	SetVehicleParam(FindVehicle("car", true), "topspeed", 200)
--- end
--- ```
--- @param handle number -- Vehicle handler
--- @param param string -- Param name
--- @param value number -- Param value
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetVehicleParam)
function SetVehicleParam(handle, param, value) end

--- ### Example
--- ```lua
--- function client.init()
--- 	local vehicle = FindVehicle("vehicle")
--- 	local driverPos = GetVehicleDriverPos(vehicle)
--- 	local t = GetVehicleTransform(vehicle)
--- 	local worldPos = TransformToParentPoint(t, driverPos)
--- 	DebugPrint(worldPos)
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return TVec pos -- Driver position as vector in vehicle space
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleDriverPos)
function GetVehicleDriverPos(vehicle) end

--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = FindVehicle("vehicle")
--- 	local pos = GetVehicleAvailableSeatPos(vehicle)
--- 	DebugPrint(pos)
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @return TVec pos -- World space position of the next available seat. {0, 0, 0} if none is available.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleAvailableSeatPos)
function GetVehicleAvailableSeatPos(vehicle) end

--- ### Example
--- ```lua
--- local steering = GetVehicleSteering(vehicle)
--- ```
--- @param vehicle number -- Vehicle handle
--- @return number steering -- Driver steering value -1 to 1
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleSteering)
function GetVehicleSteering(vehicle) end

--- ### Example
--- ```lua
--- local drive = GetVehicleDrive(vehicle)
--- ```
--- @param vehicle number -- Vehicle handle
--- @return number drive -- Driver drive value -1 to 1
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleDrive)
function GetVehicleDrive(vehicle) end

--- ### SERVER ONLY
--- This function applies input to vehicles, allowing for autonomous driving. The vehicle
--- will be turned on automatically and turned off when no longer called. Call this from
--- the tick function, not update.
--- ### Example
--- ```lua
--- function server.tick()
--- 	--Drive mycar forwards
--- 	local v = FindVehicle("mycar")
--- 	DriveVehicle(v, 1, 0, false)
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @param drive number -- Reverse/forward control -1 to 1
--- @param steering number -- Left/right control -1 to 1
--- @param handbrake boolean -- Handbrake control
--- [View Documentation](https://teardowngame.com/experimental/api.html#DriveVehicle)
function DriveVehicle(vehicle, drive, steering, handbrake) end

--- ### Example
--- ```lua
--- local t = GetVehicleLocationWorldTransform(vehicle, "player_steeringwheel")
--- ```
--- @param vehicle number -- Vehicle handle
--- @param name string -- Name of location
--- @return TTransform transform -- World transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehicleLocationWorldTransform)
function GetVehicleLocationWorldTransform(vehicle, name) end

--- ### Example
--- ```lua
--- local passengers, seats, hasDriver = GetVehiclePassengerCount(vehicle)
--- ```
--- @param vehicle number -- Vehicle handle
--- @return number count -- Number of passengers
--- @return number seats -- Number of seats
--- @return boolean hasDriver -- If vehicle has a driver
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetVehiclePassengerCount)
function GetVehiclePassengerCount(vehicle) end

--- ### SERVER ONLY
--- Works only for vehicles with 'customhealth' tag. 'customhealth' disables the common vehicles damage system.
--- So this function needed for custom vehicle damage systems.
--- ### Example
--- ```lua
--- function server.tick()
--- 	if InputPressed("usetool", playerId) then
--- 		SetVehicleHealth(FindVehicle("car", true), 0.0)
--- 	end
--- end
--- ```
--- @param vehicle number -- Vehicle handle
--- @param health number -- Set vehicle health (between zero and one)
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetVehicleHealth)
function SetVehicleHealth(vehicle, health) end

