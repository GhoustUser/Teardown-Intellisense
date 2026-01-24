--- @meta


--- @alias QueryRequire_Layer
--- | 'physical' have a physical representation
--- | 'dynamic' part of a dynamic body
--- | 'static' part of a static body
--- | 'large' above debris threshold
--- | 'small' below debris threshold
--- | 'visible' only hit visible shapes
--- | 'animator' part of an animator hierarchy
--- | 'player' part of an player animator hierarchy
--- | 'tool' part of a tool

--- @alias QueryInclude_Layer
--- | 'physical' have a physical representation
--- | 'dynamic' part of a dynamic body
--- | 'static' part of a static body
--- | 'large' above debris threshold
--- | 'small' below debris threshold
--- | 'visible' only hit visible shapes
--- | 'animator' part of an animator hierarchy
--- | 'player' part of an player
--- | 'tool' part of a tool

--- @alias GetPathState_State
--- | 'idle' No recent query
--- | 'busy' Busy computing. No path found yet.
--- | 'fail' Failed to find path. You can still get the resulting path (even though it won't reach the target).
--- | 'done' Path planning completed and a path was found. Get it with GetPathLength and GetPathPoint)

--- @param layers string -- Space separate list of layers
--- ### Example
--- ```lua
--- --Raycast dynamic, physical objects above debris threshold, but not specific vehicle
--- function client.tick()
--- 	local vehicle = FindVehicle("vehicle")
--- 	QueryRequire("physical dynamic large")
--- 	QueryRejectVehicle(vehicle)
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRequire)
function QueryRequire(layers) end

--- @param layers string -- Space separate list of layers
--- ### Example
--- ```lua
--- --Raycast all the default layers and include the player layer.
--- function client.tick()
--- 	QueryInclude("player")
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryInclude)
function QueryInclude(layers) end

--- Set collision mask filter for the next query. Queries have a mask of 255 by default
--- @param mask number -- Mask bits (0-255)
--- ### Example
--- ```lua
--- --Find the closest point on any shape (within 2 meters) to the player eye that the player can collide with.
--- function client.tick()
--- 	QueryRequire("physical")
--- 	QueryCollisionMask(GetPlayerParam("CollisionMask"))
--- 	local hit, hitpos = QueryClosestPoint(GetPlayerEyeTransform().pos, 2)
--- 	if hit then
--- 		DebugCross(hitpos)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryCollisionMask)
function QueryCollisionMask(mask) end

--- Exclude animator from the next query
--- @param handle number -- Animator handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectAnimator)
function QueryRejectAnimator(handle) end

--- Exclude vehicle from the next query
--- @param vehicle number -- Vehicle handle
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = FindVehicle("vehicle")
--- 	QueryRequire("physical dynamic large")
--- 	--Do not include vehicle in next raycast
--- 	QueryRejectVehicle(vehicle)
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectVehicle)
function QueryRejectVehicle(vehicle) end

--- Exclude body from the next query
--- @param body number -- Body handle
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = FindBody("body")
--- 	QueryRequire("physical dynamic large")
--- 	--Do not include body in next raycast
--- 	QueryRejectBody(body)
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectBody)
function QueryRejectBody(body) end

--- Exclude bodies from the next query
--- @param bodies table -- Array with bodies handles
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = FindBody("body")
--- 	QueryRequire("physical dynamic large")
--- 	local bodies = {body}
--- 	--Do not include body in next raycast
--- 	QueryRejectBodies(bodies)
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectBodies)
function QueryRejectBodies(bodies) end

--- Exclude shape from the next query
--- @param shape number -- Shape handle
--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = FindShape("shape")
--- 	QueryRequire("physical dynamic large")
--- 	--Do not include shape in next raycast
--- 	QueryRejectShape(shape)
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectShape)
function QueryRejectShape(shape) end

--- Exclude shapes from the next query
--- @param shapes table -- Array with shapes handles
--- ### Example
--- ```lua
--- function client.tick()
--- 	local shape = FindShape("shape")
--- 	QueryRequire("physical dynamic large")
--- 	local shapes = {shape}
--- 	--Do not include shape in next raycast
--- 	QueryRejectShapes(shapes)
--- 	local hit, dist = QueryRaycast(Vec(0, 0, 0), Vec(1, 0, 0), 10)
--- 	if hit then
--- 		DebugPrint(dist)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectShapes)
function QueryRejectShapes(shapes) end

--- Exclude player from the next query
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server (host) player.
--- ### Example
--- ```lua
--- --Do not include shape in next raycast
--- QueryRejectPlayer(1)
--- QueryRaycast(...)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRejectPlayer)
function QueryRejectPlayer(playerId) end

--- This will perform a raycast or spherecast (if radius is more than zero) query.
--- If you want to set up a filter for the query you need to do so before every call
--- to this function.
--- @param origin TVec -- Raycast origin as world space vector
--- @param direction TVec -- Unit length raycast direction as world space vector
--- @param maxDist number -- Raycast maximum distance. Keep this as low as possible for good performance.
--- @param radius? number -- Raycast thickness. Default zero.
--- @param rejectTransparent? boolean -- Raycast through transparent materials. Default false.
--- @return boolean hit -- True if raycast hit something
--- @return number dist -- Hit distance from origin
--- @return TVec normal -- World space normal at hit point
--- @return number shape -- Handle to hit shape
--- ### Example
--- ```lua
--- function client.init()
--- 	local vehicle = FindVehicle("vehicle")
--- 	QueryRejectVehicle(vehicle)
--- 	--Raycast from a high point straight downwards, excluding a specific vehicle
--- 	local hit, d = QueryRaycast(Vec(0, 100, 0), Vec(0, -1, 0), 100)
--- 	if hit then
--- 		DebugPrint(d)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRaycast)
function QueryRaycast(origin, direction, maxDist, radius, rejectTransparent) end

--- This will perform a raycast query that returns the handle of the joint of rope type when if collides with it.
--- There are no filters for this type of raycast.
--- @param origin TVec -- Raycast origin as world space vector
--- @param direction TVec -- Unit length raycast direction as world space vector
--- @param maxDist number -- Raycast maximum distance. Keep this as low as possible for good performance.
--- @param radius? number -- Raycast thickness. Default zero.
--- @return boolean hit -- True if raycast hit something
--- @return number dist -- Hit distance from origin
--- @return number joint -- Handle to hit joint of rope type
--- ### Example
--- ```lua
--- function client.tick()
--- 	local playerCameraTransform = GetPlayerCameraTransform()
--- 	local dir = TransformToParentVec(playerCameraTransform, Vec(0, 0, -1))
--- 	local hit, dist, joint = QueryRaycastRope(playerCameraTransform.pos, dir, 10)
--- 	if hit then
--- 		DebugWatch("distance", dist)
--- 		DebugWatch("joint", joint)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRaycastRope)
function QueryRaycastRope(origin, direction, maxDist, radius) end

--- This will perform a raycast query looking for water.
--- @param origin TVec -- Raycast origin as world space vector
--- @param direction TVec -- Unit length raycast direction as world space vector
--- @param maxDist number -- Raycast maximum distance. Keep this as low as possible for good performance.
--- @return boolean hit -- True if raycast hit something
--- @return number dist -- Hit distance from origin
--- @return TVec hitPos -- Hit point as world space vector
--- ### Example
--- ```lua
--- function client.init()
--- 	--Raycast from a high point straight downwards, looking for water
--- 	local hit, d = QueryRaycast(Vec(0, 100, 0), Vec(0, -1, 0), 100)
--- 	if hit then
--- 		DebugPrint(d)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryRaycastWater)
function QueryRaycastWater(origin, direction, maxDist) end

--- Test to see if a projectile would hit a shape or a player. It will return either a valid
--- shape ID, player ID or none.
--- @param origin TVec -- Shot ray origin as world space vector
--- @param direction TVec -- Unit length direction as world space vector
--- @param maxDist number -- Shot maximum distance. Keep this as low as possible for good performance.
--- @param radius? number -- Ray thickness. Default zero.
--- @param playerId? number -- Instigating player, will be ignored during hit detection.
--- @return boolean didHit -- If it was a valid hit.
--- @return number dist -- Distance along direction where the hit was registered.
--- @return number shape -- Handle to hit shape, zero if it did not hit a shape
--- @return number playerId -- PlayerId of hit player, zero if it did not hit a player
--- @return number playerDamageFactor -- 1.0 for a hit on the torso, and less for a lower body hit. Applicable only if a player was hit. Use this to scale the damage.
--- @return TVec normal -- Normal vector of the hit
--- ### Example
--- ```lua
--- -- Note: 'shape' and 'player' are IDs/handles (numbers), not object references.
--- function server.tick()
--- 	for p in Players() do
--- 		if InputPressed("usetool", p) then
--- 			local pos = GetPlayerEyeTransform(p).pos
--- 			local dir = TransformToParentVec(GetPlayerEyeTransform(p), Vec(0, 0, -1))
--- 			local hit, dist, shape, player, hitFactor, normal = QueryShot(pos, dir, 100, 0, p)
--- 			if hit then
--- 				if player then
--- 					DebugPrint("Hit player " .. GetPlayerName(player) .. " with damage factor " .. hitFactor)
--- 					ApplyPlayerDamage(player, 0.2 * hitFactor, "SuperGun", p)
--- 				elseif shape then
--- 					DebugPrint("Hit shape " .. shape .. " at distance " .. dist)
--- 					local body = GetShapeBody(shape)
--- 					local impPos = VecAdd(pos, VecScale(dir, dist))
--- 					local imp = Vec(100, 0, 0)
--- 					ApplyBodyImpulse(body, impPos, imp)
--- 				end
--- 			else
--- 				DebugPrint("No hit")
--- 			end
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryShot)
function QueryShot(origin, direction, maxDist, radius, playerId) end

--- This will query the closest point to all shapes in the world. If you
--- want to set up a filter for the query you need to do so before every call
--- to this function.
--- @param origin TVec -- World space point
--- @param maxDist number -- Maximum distance. Keep this as low as possible for good performance.
--- @return boolean hit -- True if a point was found
--- @return TVec point -- World space closest point
--- @return TVec normal -- World space normal at closest point
--- @return number shape -- Handle to closest shape
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vehicle = FindVehicle("vehicle")
--- 	--Find closest point within 10 meters of {0, 5, 0}, excluding any point on myVehicle
--- 	QueryRejectVehicle(vehicle)
--- 	local hit, p, n, s = QueryClosestPoint(Vec(0, 5, 0), 10)
--- 	if hit then
--- 		DebugPrint(p)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryClosestPoint)
function QueryClosestPoint(origin, maxDist) end

--- Return all shapes within the provided world space, axis-aligned bounding box
--- @param min TVec -- Aabb minimum point
--- @param max TVec -- Aabb maximum point
--- @return table list -- Indexed table with handles to all shapes in the aabb
--- ### Example
--- ```lua
--- function client.tick()
--- 	local list = QueryAabbShapes(Vec(0, 0, 0), Vec(10, 10, 10))
--- 	for i=1, #list do
--- 		local shape = list[i]
--- 		DebugPrint(shape)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryAabbShapes)
function QueryAabbShapes(min, max) end

--- Return all bodies within the provided world space, axis-aligned bounding box
--- @param min TVec -- Aabb minimum point
--- @param max TVec -- Aabb maximum point
--- @return table list -- Indexed table with handles to all bodies in the aabb
--- ### Example
--- ```lua
--- function client.tick()
--- 	local list = QueryAabbBodies(Vec(0, 0, 0), Vec(10, 10, 10))
--- 	for i=1, #list do
--- 		local body = list[i]
--- 		DebugPrint(body)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryAabbBodies)
function QueryAabbBodies(min, max) end

--- Initiate path planning query. The result will run asynchronously as long as GetPathState
--- returns "busy". An ongoing path query can be aborted with AbortPath. The path planning query
--- will use the currently set up query filter, just like the other query functions.
--- Using the 'water' type allows you to build a path within the water.
--- The 'flying' type builds a path in the entire three-dimensional space.
--- @param start TVec -- World space start point
--- @param end_arg TVec -- World space target point
--- @param maxDist? number -- Maximum path length before giving up. Default is infinite.
--- @param targetRadius? number -- Maximum allowed distance to target in meters. Default is 2.0
--- @param type? string -- Type of path. Can be "low", "standart", "water", "flying". Default is "standart"
--- ### Example
--- ```lua
--- function client.init()
--- 	QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QueryPath)
function QueryPath(start, end_arg, maxDist, targetRadius, type) end

--- Creates a new path planner that can be used to calculate multiple paths in parallel.
--- It is supposed to be used together with PathPlannerQuery.
--- Returns created path planner id/handler.
--- It is recommended to reuse previously created path planners, because they exist throughout the lifetime of the script.
--- @return number id -- Path planner id
--- ### Example
--- ```lua
--- local paths = {}
--- function server.init()
--- 	paths[1] = {
--- 		id = CreatePathPlanner(),
--- 		location = GetProperty(FindEntity("loc1", true), "transform").pos,
--- 	}
--- 	paths[2] = {
--- 		id = CreatePathPlanner(),
--- 		location = GetProperty(FindEntity("loc2", true), "transform").pos,
--- 	}
--- 	for i = 1, #paths do
--- 		PathPlannerQuery(paths[i].id, GetPlayerTransform().pos, paths[i].location)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#CreatePathPlanner)
function CreatePathPlanner() end

--- Deletes the path planner with the specified id which can be used to save some memory.
--- Calling CreatePathPlanner again can initialize a new path planner with the id previously deleted.
--- @param id number -- Path planner id
--- ### Example
--- ```lua
--- local paths = {}
--- function server.init()
--- 	local id = CreatePathPlanner()
--- 	DeletePathPlanner(id)
--- 	-- now calling PathPlannerQuery for 'id' will result in an error
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DeletePathPlanner)
function DeletePathPlanner(id) end

--- It works similarly to QueryPath but several paths can be built simultaneously within the same script.
--- The QueryPath automatically creates a path planner with an index of 0 and only works with it.
--- @param id number -- Path planner id
--- @param start TVec -- World space start point
--- @param end_arg TVec -- World space target point
--- @param maxDist? number -- Maximum path length before giving up. Default is infinite.
--- @param targetRadius? number -- Maximum allowed distance to target in meters. Default is 2.0
--- @param type? string -- Type of path. Can be "low", "standart", "water", "flying". Default is "standart"
--- ### Example
--- ```lua
--- local paths = {}
--- function server.init()
--- 	paths[1] = {
--- 		id = CreatePathPlanner(),
--- 		location = GetProperty(FindEntity("loc1", true), "transform").pos,
--- 	}
--- 	paths[2] = {
--- 		id = CreatePathPlanner(),
--- 		location = GetProperty(FindEntity("loc2", true), "transform").pos,
--- 	}
--- 	for i = 1, #paths do
--- 		PathPlannerQuery(paths[i].id, GetPlayerTransform().pos, paths[i].location)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#PathPlannerQuery)
function PathPlannerQuery(id, start, end_arg, maxDist, targetRadius, type) end

--- Abort current path query, regardless of what state it is currently in. This is a way to
--- save computing resources if the result of the current query is no longer of interest.
--- @param id? number -- Path planner id. Default value is 0.
--- ### Example
--- ```lua
--- function server.init()
--- 	QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
--- 	AbortPath()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#AbortPath)
function AbortPath(id) end

--- @param id? number -- Path planner id. Default value is 0.
--- @return GetPathState_State state -- Current path planning state
--- ### Example
--- ```lua
--- function server.init()
--- 	QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
--- end
--- function server.tick()
--- 	local s = GetPathState()
--- 	if s == "done" then
--- 		DebugPrint("done")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPathState)
function GetPathState(id) end

--- Return the path length of the most recently computed path query. Note that the result can often be retrieved even
--- if the path query failed. If the target point couldn't be reached, the path endpoint will be the point closest
--- to the target.
--- @param id? number -- Path planner id. Default value is 0.
--- @return number length -- Length of last path planning result (in meters)
--- ### Example
--- ```lua
--- function server.init()
--- 	QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
--- end
--- function server.tick()
--- 	local s = GetPathState()
--- 	if s == "done" then
--- 		DebugPrint("done " .. GetPathLength())
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPathLength)
function GetPathLength(id) end

--- Return a point along the path for the most recently computed path query. Note that the result can often be retrieved even
--- if the path query failed. If the target point couldn't be reached, the path endpoint will be the point closest
--- to the target.
--- @param dist number -- The distance along path. Should be between zero and result from GetPathLength()
--- @param id? number -- Path planner id. Default value is 0.
--- @return TVec point -- The path point dist meters along the path
--- ### Example
--- ```lua
--- function client.init()
--- 	QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
--- end
--- function client.tick()
--- 	local d = 0
--- 	local l = GetPathLength()
--- 	while d < l do
--- 		DebugCross(GetPathPoint(d))
--- 		d = d + 0.5
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetPathPoint)
function GetPathPoint(dist, id) end

--- @return number volume -- Volume of loudest sound played last frame
--- @return TVec position -- World position of loudest sound played last frame
--- ### Example
--- ```lua
--- function client.tick()
--- 	local vol, pos = GetLastSound()
--- 	if vol > 0 then
--- 		DebugPrint(vol .. " " .. VecStr(pos))
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetLastSound)
function GetLastSound() end

--- @param point TVec -- World point as vector
--- @return boolean inWater -- True if point is in water
--- @return number depth -- Depth of point into water, or zero if not in water
--- ### Example
--- ```lua
--- function client.tick()
--- 	local wet, d = IsPointInWater(Vec(10, 0, 0))
--- 	if wet then
--- 		DebugPrint("point" .. d .. " meters into water")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsPointInWater)
function IsPointInWater(point) end

--- Get the wind velocity at provided point. The wind will be determined by wind property of
--- the environment, but it varies with position procedurally.
--- @param point TVec -- World point as vector
--- @return TVec vel -- Wind at provided position
--- ### Example
--- ```lua
--- function client.tick()
--- 	local v = GetWindVelocity(Vec(0, 10, 0))
--- 	DebugPrint(VecStr(v))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetWindVelocity)
function GetWindVelocity(point) end

