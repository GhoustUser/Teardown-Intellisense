--- @meta


--- A body represents a rigid body in the scene. It can be either static or dynamic. Only dynamic bodies are affected by physics. 


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first body with specified tag or zero if not found
--- ### Example
--- ```lua
--- function init()
--- 	--Search for a body tagged "target" in script scope
--- 	local target = FindBody("body")
--- 	DebugPrint(target)
--- 	--Search for a body tagged "escape" in entire scene
--- 	local escape = FindBody("body", true)
--- 	DebugPrint(escape)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindBody)
function FindBody(tag, global) end

--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all bodies with specified tag
--- ### Example
--- ```lua
--- function init()
--- 	--Search for bodies tagged "target" in script scope
--- 	local targets = FindBodies("target", true)
--- 	for i=1, #targets do
--- 		local target = targets[i]
--- 		DebugPrint(target)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindBodies)
function FindBodies(tag, global) end

--- @param handle number -- Body handle
--- @return TTransform transform -- Transform of the body
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("target", true)
--- 	local t = GetBodyTransform(handle)
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyTransform)
function GetBodyTransform(handle) end

--- @param handle number -- Body handle
--- @param transform TTransform -- Desired transform
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Move a body 1 meter upwards
--- 	local t = GetBodyTransform(handle)
--- 	t.pos = VecAdd(t.pos, Vec(0, 3, 0))
--- 	SetBodyTransform(handle, t)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBodyTransform)
function SetBodyTransform(handle, transform) end

--- @param handle number -- Body handle
--- @return number mass -- Body mass. Static bodies always return zero mass.
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Move a body 1 meter upwards
--- 	local mass = GetBodyMass(handle)
--- 	DebugPrint(mass)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyMass)
function GetBodyMass(handle) end

--- Check if body is dynamic. Note that something that was created static
--- may become dynamic due to destruction.
--- @param handle number -- Body handle
--- @return boolean dynamic -- Return true if body is dynamic
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	DebugPrint(IsBodyDynamic(handle))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsBodyDynamic)
function IsBodyDynamic(handle) end

--- Change the dynamic state of a body. There is very limited use for this
--- function. In most situations you should leave it up to the engine to decide.
--- Use with caution.
--- @param handle number -- Body handle
--- @param dynamic boolean -- True for dynamic. False for static.
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	SetBodyDynamic(handle, false)
--- 	DebugPrint(IsBodyDynamic(handle))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBodyDynamic)
function SetBodyDynamic(handle, dynamic) end

--- This can be used for animating bodies with preserved physical interaction,
--- but in most cases you are better off with a motorized joint instead.
--- @param handle number -- Body handle (should be a dynamic body)
--- @param velocity TVec -- Vector with linear velocity
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	local vel = Vec(0,10,0)
--- 	SetBodyVelocity(handle, vel)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBodyVelocity)
function SetBodyVelocity(handle, velocity) end

--- @param handle number -- Body handle (should be a dynamic body)
--- @return TVec velocity -- Linear velocity as vector
--- ### Example
--- ```lua
--- handle = 0
--- function server.init()
--- 	handle = FindBody("body", true)
--- 	local vel = Vec(0,10,0)
--- 	SetBodyVelocity(handle, vel)
--- end
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	DebugPrint(VecStr(GetBodyVelocity(handle)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyVelocity)
function GetBodyVelocity(handle) end

--- Return the velocity on a body taking both linear and angular velocity into account.
--- @param handle number -- Body handle (should be a dynamic body)
--- @param pos TVec -- World space point as vector
--- @return TVec velocity -- Linear velocity on body at pos as vector
--- ### Example
--- ```lua
--- handle = 0
--- function server.init()
--- 	handle = FindBody("body", true)
--- 	local vel = Vec(0,10,0)
--- 	SetBodyVelocity(handle, vel)
--- end
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	DebugPrint(VecStr(GetBodyVelocityAtPos(handle, Vec(0, 0, 0))))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyVelocityAtPos)
function GetBodyVelocityAtPos(handle, pos) end

--- This can be used for animating bodies with preserved physical interaction,
--- but in most cases you are better off with a motorized joint instead.
--- @param handle number -- Body handle (should be a dynamic body)
--- @param angVel TVec -- Vector with angular velocity
--- ### Example
--- ```lua
--- function server.init()
--- 	handle = FindBody("body", true)
--- 	local angVel = Vec(0,100,0)
--- 	SetBodyAngularVelocity(handle, angVel)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBodyAngularVelocity)
function SetBodyAngularVelocity(handle, angVel) end

--- @param handle number -- Body handle (should be a dynamic body)
--- @return TVec angVel -- Angular velocity as vector
--- ### Example
--- ```lua
--- handle = 0
--- function server.init()
--- 	handle = FindBody("body", true)
--- 	local angVel = Vec(0,100,0)
--- 	SetBodyAngularVelocity(handle, angVel)
--- end
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	DebugPrint(VecStr(GetBodyAngularVelocity(handle)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyAngularVelocity)
function GetBodyAngularVelocity(handle) end

--- Check if body is body is currently simulated. For performance reasons,
--- bodies that don't move are taken out of the simulation. This function
--- can be used to query the active state of a specific body. Only dynamic
--- bodies can be active.
--- @param handle number -- Body handle
--- @return boolean active -- Return true if body is active
--- ### Example
--- ```lua
--- -- try to break the body to see the logs
--- function client.tick()
--- 	handle = FindBody("body", true)
--- 	if IsBodyActive(handle) then
--- 		DebugPrint("Body is active")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsBodyActive)
function IsBodyActive(handle) end

--- This function makes it possible to manually activate and deactivate bodies to include or
--- exclude in simulation. The engine normally handles this automatically, so use with care.
--- @param handle number -- Body handle
--- @param active boolean -- Set to tru if body should be active (simulated)
--- ### Example
--- ```lua
--- handle = 0
--- function server.tick()
--- 	handle = FindBody("body", true)
--- 	-- Forces body to "sleep"
--- 	SetBodyActive(handle, false)
--- end
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	handle = FindBody("body", true)
--- 	if IsBodyActive(handle) then
--- 		DebugPrint("Body is active")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBodyActive)
function SetBodyActive(handle, active) end

--- Apply impulse to dynamic body at position (give body a push).
--- @param handle number -- Body handle (should be a dynamic body)
--- @param position TVec -- World space position as vector
--- @param impulse TVec -- World space impulse as vector
--- ### Example
--- ```lua
--- function applyImpulse()
--- 	handle = FindBody("body", true)
--- 	local pos = Vec(0,1,0)
--- 	local imp = Vec(0,0,10)
--- 	ApplyBodyImpulse(handle, pos, imp)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ApplyBodyImpulse)
function ApplyBodyImpulse(handle, position, impulse) end

--- Return handles to all shapes owned by a body
--- @param handle number -- Body handle
--- @return table list -- Indexed table of shape handles
--- ### Example
--- ```lua
--- function client.init()
--- 	handle = FindBody("body", true)
--- 	local shapes = GetBodyShapes(handle)
--- 	for i=1,#shapes do
--- 		local shape = shapes[i]
--- 		DebugPrint(shape)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyShapes)
function GetBodyShapes(handle) end

--- @param body number -- Body handle
--- @return number handle -- Get parent vehicle for body, or zero if not part of vehicle
--- ### Example
--- ```lua
--- function client.init()
--- 	handle = FindBody("body", true)
--- 	local vehicle = GetBodyVehicle(handle)
--- 	DebugPrint(vehicle)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyVehicle)
function GetBodyVehicle(body) end

--- @param body number -- Body handle
--- @return number handle -- Get parent animator for body, or zero if not part of an animator hierarchy
--- ### Example
--- ```lua
--- local animator = GetBodyAnimator(body)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyAnimator)
function GetBodyAnimator(body) end

--- @param body number -- Body handle
--- @return number playerId -- Get parent player for body, or zero if not part of a player animator hierarchy
--- ### Example
--- ```lua
--- local player = GetBodyPlayer(body)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyPlayer)
function GetBodyPlayer(body) end

--- Return the world space, axis-aligned bounding box for a body.
--- @param handle number -- Body handle
--- @return TVec min -- Vector representing the AABB lower bound
--- @return TVec max -- Vector representing the AABB upper bound
--- ### Example
--- ```lua
--- function client.init()
--- 	handle = FindBody("body", true)
--- 	local min, max = GetBodyBounds(handle)
--- 	local boundsSize = VecSub(max, min)
--- 	local center = VecLerp(min, max, 0.5)
--- 	DebugPrint(VecStr(boundsSize) .. " " .. VecStr(center))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyBounds)
function GetBodyBounds(handle) end

--- @param handle number -- Body handle
--- @return TVec point -- Vector representing local center of mass in body space
--- ### Example
--- ```lua
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	--Visualize center of mass on for body
--- 	local com = GetBodyCenterOfMass(handle)
--- 	local worldPoint = TransformToParentPoint(GetBodyTransform(handle), com)
--- 	DebugCross(worldPoint)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyCenterOfMass)
function GetBodyCenterOfMass(handle) end

--- This function does a very rudimetary check and will only return true if the 
--- object is visible within 74 degrees of the camera's forward direction, and
--- only tests line-of-sight visibility for the corners and center of the bounding box.
--- @param handle number -- Body handle
--- @param maxDist number -- Maximum visible distance
--- @param rejectTransparent? boolean -- See through transparent materials. Default false.
--- @param playerId? number -- Player ID. On player, zero means local player.
--- @return boolean visible -- Return true if body is visible
--- ### Example
--- ```lua
--- local handle = 0
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	if IsBodyVisible(handle, 25) then
--- 		--Body is within 25 meters visible to the camera
--- 		DebugPrint("visible")
--- 	else
--- 		DebugPrint("not visible")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsBodyVisible)
function IsBodyVisible(handle, maxDist, rejectTransparent, playerId) end

--- Determine if any shape of a body has been broken.
--- @param handle number -- Body handle
--- @return boolean broken -- Return true if body is broken
--- ### Example
--- ```lua
--- local handle = 0
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	DebugPrint(IsBodyBroken(handle))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsBodyBroken)
function IsBodyBroken(handle) end

--- Determine if a body is in any way connected to a static object, either by being static itself or
--- be being directly or indirectly jointed to something static.
--- @param handle number -- Body handle
--- @return boolean result -- Return true if body is in any way connected to a static body
--- ### Example
--- ```lua
--- local handle = 0
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	DebugPrint(IsBodyJointedToStatic(handle))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsBodyJointedToStatic)
function IsBodyJointedToStatic(handle) end

--- Render next frame with an outline around specified body.
--- If no color is given, a white outline will be drawn.
--- @param handle number -- Body handle
--- @param r? number -- Red
--- @param g? number -- Green
--- @param b? number -- Blue
--- @param a? number -- Alpha
--- ### Example
--- ```lua
--- local handle = 0
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	if InputDown("interact") then
--- 		--Draw white outline at 50% transparency
--- 		DrawBodyOutline(handle, 0.5)
--- 	else
--- 		--Draw green outline, fully opaque
--- 		DrawBodyOutline(handle, 0, 1, 0, 1)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawBodyOutline)
function DrawBodyOutline(handle, r, g, b, a) end

--- Flash the appearance of a body when rendering this frame. This is
--- used for valuables in the game.
--- @param handle number -- Body handle
--- @param amount number -- Amount
--- ### Example
--- ```lua
--- local handle = 0
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	if InputDown("interact") then
--- 		DrawBodyHighlight(handle, 0.5)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawBodyHighlight)
function DrawBodyHighlight(handle, amount) end

--- This will return the closest point of a specific body
--- @param body number -- Body handle
--- @param origin TVec -- World space point
--- @return boolean hit -- True if a point was found
--- @return TVec point -- World space closest point
--- @return TVec normal -- World space normal at closest point
--- @return number shape -- Handle to closest shape
--- ### Example
--- ```lua
--- local handle = 0
--- function client.init()
--- 	handle = FindBody("body", true)
--- end
--- function client.tick()
--- 	DebugCross(Vec(1, 0, 0))
--- 	local hit, p, n, s = GetBodyClosestPoint(handle, Vec(1, 0, 0))
--- 	if hit then
--- 		DebugCross(p)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBodyClosestPoint)
function GetBodyClosestPoint(body, origin) end

--- This will tell the physics solver to constrain the velocity between two bodies. The physics solver
--- will try to reach the desired goal, while not applying an impulse bigger than the min and max values.
--- This function should only be used from the update callback.
--- @param bodyA number -- First body handle (zero for static)
--- @param bodyB number -- Second body handle (zero for static)
--- @param point TVec -- World space point
--- @param dir TVec -- World space direction
--- @param relVel number -- Desired relative velocity along the provided direction
--- @param min? number -- Minimum impulse (default: -infinity)
--- @param max? number -- Maximum impulse (default: infinity)
--- ### Example
--- ```lua
--- local handleA = 0
--- local handleB = 0
--- function server.init()
--- 	handleA = FindBody("body", true)
--- 	handleB = FindBody("target", true)
--- end
--- function server.update()
--- 	--Constrain the velocity between bodies A and B so that the relative velocity
--- 	--along the X axis at point (0, 5, 0) is always 3 m/s
--- 	ConstrainVelocity(handleA, handleB, Vec(0, 5, 0), Vec(1, 0, 0), 3)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ConstrainVelocity)
function ConstrainVelocity(bodyA, bodyB, point, dir, relVel, min, max) end

--- This will tell the physics solver to constrain the angular velocity between two bodies. The physics solver
--- will try to reach the desired goal, while not applying an angular impulse bigger than the min and max values.
--- This function should only be used from the update callback.
--- @param bodyA number -- First body handle (zero for static)
--- @param bodyB number -- Second body handle (zero for static)
--- @param dir TVec -- World space direction
--- @param relAngVel number -- Desired relative angular velocity along the provided direction
--- @param min? number -- Minimum angular impulse (default: -infinity)
--- @param max? number -- Maximum angular impulse (default: infinity)
--- ### Example
--- ```lua
--- local handleA = 0
--- local handleB = 0
--- function server.init()
--- 	handleA = FindBody("body", true)
--- 	handleB = FindBody("target", true)
--- end
--- function server.update()
--- 	--Constrain the angular velocity between bodies A and B so that the relative angular velocity
--- 	--along the Y axis is always 3 rad/s
--- 	ConstrainAngularVelocity(handleA, handleB, Vec(1, 0, 0), 3)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ConstrainAngularVelocity)
function ConstrainAngularVelocity(bodyA, bodyB, dir, relAngVel, min, max) end

--- This is a helper function that uses ConstrainVelocity to constrain a point on one
--- body to a point on another body while not affecting the bodies more than the provided
--- maximum relative velocity and maximum impulse. In other words: physically push on
--- the bodies so that pointA and pointB are aligned in world space. This is useful for
--- physically animating objects. This function should only be used from the update callback.
--- @param bodyA number -- First body handle (zero for static)
--- @param bodyB number -- Second body handle (zero for static)
--- @param pointA TVec -- World space point for first body
--- @param pointB TVec -- World space point for second body
--- @param maxVel? number -- Maximum relative velocity (default: infinite)
--- @param maxImpulse? number -- Maximum impulse (default: infinite)
--- ### Example
--- ```lua
--- local handleA = 0
--- local handleB = 0
--- function server.init()
--- 	handleA = FindBody("body", true)
--- 	handleB = FindBody("target", true)
--- end
--- function server.update()
--- 	--Constrain the origo of body a to an animated point in the world
--- 	local worldPos = Vec(0, 3+math.sin(GetTime()), 0)
--- 	ConstrainPosition(handleA, 0, GetBodyTransform(handleA).pos, worldPos)
--- 	--Constrain the origo of body a to the origo of body b (like a ball joint)
--- 	ConstrainPosition(handleA, handleA, GetBodyTransform(handleA).pos, GetBodyTransform(handleB).pos)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ConstrainPosition)
function ConstrainPosition(bodyA, bodyB, pointA, pointB, maxVel, maxImpulse) end

--- This is the angular counterpart to ConstrainPosition, a helper function that uses
--- ConstrainAngularVelocity to constrain the orientation of one body to the orientation
--- on another body while not affecting the bodies more than the provided maximum relative
--- angular velocity and maximum angular impulse. In other words: physically rotate the
--- bodies so that quatA and quatB are aligned in world space. This is useful for
--- physically animating objects. This function should only be used from the update callback.
--- @param bodyA number -- First body handle (zero for static)
--- @param bodyB number -- Second body handle (zero for static)
--- @param quatA TQuat -- World space orientation for first body
--- @param quatB TQuat -- World space orientation for second body
--- @param maxAngVel? number -- Maximum relative angular velocity (default: infinite)
--- @param maxAngImpulse? number -- Maximum angular impulse (default: infinite)
--- ### Example
--- ```lua
--- local handleA = 0
--- local handleB = 0
--- function server.init()
--- 	handleA = FindBody("body", true)
--- 	handleB = FindBody("target", true)
--- end
--- function server.update()
--- 	--Constrain the orietation of body a to an upright orientation in the world
--- 	ConstrainOrientation(handleA, 0, GetBodyTransform(handleA).rot, Quat())
--- 	--Constrain the orientation of body a to the orientation of body b
--- 	ConstrainOrientation(handleA, handleB, GetBodyTransform(handleA).rot, GetBodyTransform(handleB).rot)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ConstrainOrientation)
function ConstrainOrientation(bodyA, bodyB, quatA, quatB, maxAngVel, maxAngImpulse) end

--- Every scene in Teardown has an implicit static world body that contains all shapes that are not explicitly assigned a body in the editor.
--- @return number body -- Handle to the static world body
--- ### Example
--- ```lua
--- local handle
--- function client.init()
--- 	handle = GetWorldBody()
--- end
--- function client.tick()
--- 	DebugCross(GetBodyTransform(handle).pos)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetWorldBody)
function GetWorldBody() end

