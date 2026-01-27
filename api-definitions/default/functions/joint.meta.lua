--- @meta


--- @alias JointType
--- | "ball"
--- | "hinge"
--- | "prismatic"
--- | "rope"


--- ### Example
--- ```lua
--- function client.init()
--- 	local joint = FindJoint("doorhinge")
--- 	DebugPrint(joint)
--- end
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first joint with specified tag or zero if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindJoint)
function FindJoint(tag, global) end

--- ### Example
--- ```lua
--- --Search for locations tagged "doorhinge" in script scope
--- function client.init()
--- 	local hinges = FindJoints("doorhinge")
--- 	for i=1, #hinges do
--- 		local joint = hinges[i]
--- 		DebugPrint(joint)
--- 	end
--- end
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all joints with specified tag
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindJoints)
function FindJoints(tag, global) end

--- ### Example
--- ```lua
--- function client.init()
--- 	local broken = IsJointBroken(FindJoint("joint"))
--- 	DebugPrint(broken)
--- end
--- ```
--- @param joint number -- Joint handle
--- @return boolean broken -- True if joint is broken
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsJointBroken)
function IsJointBroken(joint) end

--- Joint type is one of the following: "ball", "hinge", "prismatic" or "rope".
--- An empty string is returned if joint handle is invalid.
--- ### Example
--- ```lua
--- function client.init()
--- 	local joint = FindJoint("joint")
--- 	if GetJointType(joint) == "rope" then
--- 		DebugPrint("Joint is rope")
--- 	end
--- end
--- ```
--- @param joint number -- Joint handle
--- @return JointType | "" type -- Joint type
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetJointType)
function GetJointType(joint) end

--- A joint is always connected to two shapes. Use this function if you know
--- one shape and want to find the other one.
--- ### Example
--- ```lua
--- function client.init()
--- 	local joint = FindJoint("joint")
--- 	--joint is connected to A and B
--- 	otherShape = GetJointOtherShape(joint, FindShape("shapeA"))
--- 	--otherShape is now B
--- 	otherShape = GetJointOtherShape(joint, FindShape("shapeB"))
--- 	--otherShape is now A
--- end
--- ```
--- @param joint number -- Joint handle
--- @param shape number -- Shape handle
--- @return number other -- Other shape handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetJointOtherShape)
function GetJointOtherShape(joint, shape) end

--- Get shapes connected to the joint.
--- ### Example
--- ```lua
--- local mainBody
--- local shapes
--- local joint
--- function server.init()
--- 	joint = FindJoint("joint")
--- 	mainBody = GetVehicleBody(FindVehicle("vehicle"))
--- 	shapes = GetJointShapes(joint)
--- end
--- function server.tick()
--- 	-- Check to see if joint chain is still connected to vehicle main body
--- 	-- If not then disable motors
--- 	local connected = false
--- 	for i=1,#shapes do
--- 		local body = GetShapeBody(shapes[i])
--- 		if body == mainBody then
--- 			connected = true
--- 		end
--- 	end
--- 	if connected then
--- 		SetJointMotor(joint, 0.5)
--- 	else
--- 		SetJointMotor(joint, 0.0)
--- 	end
--- end
--- ```
--- @param joint number -- Joint handle
--- @return number shapes -- Shape handles
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetJointShapes)
function GetJointShapes(joint) end

--- Set joint motor target velocity. If joint is of type hinge, velocity is
--- given in radians per second angular velocity. If joint type is prismatic joint
--- velocity is given in meters per second. Calling this function will override and
--- void any previous call to SetJointMotorTarget.
--- ### Example
--- ```lua
--- function server.init()
--- 	--Set motor speed to 0.5 radians per second
--- 	SetJointMotor(FindJoint("hinge"), 0.5)
--- end
--- ```
--- @param joint number -- Joint handle
--- @param velocity number -- Desired velocity
--- @param strength? number -- Desired strength. Default is infinite. Zero to disable.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetJointMotor)
function SetJointMotor(joint, velocity, strength) end

--- If a joint has a motor target, it will try to maintain its relative movement. This
--- is very useful for elevators or other animated, jointed mechanisms.
--- If joint is of type hinge, target is an angle in degrees (-180 to 180) and velocity
--- is given in radians per second. If joint type is prismatic, target is given
--- in meters and velocity is given in meters per second. Setting a motor target will
--- override any previous call to SetJointMotor.
--- ### Example
--- ```lua
--- function server.init()
--- 	--Make joint reach a 45 degree angle, going at a maximum of 3 radians per second
--- 	SetJointMotorTarget(FindJoint("hinge"), 45, 3)
--- end
--- ```
--- @param joint number -- Joint handle
--- @param target number -- Desired movement target
--- @param maxVel? number -- Maximum velocity to reach target. Default is infinite.
--- @param strength? number -- Desired strength. Default is infinite. Zero to disable.
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetJointMotorTarget)
function SetJointMotorTarget(joint, target, maxVel, strength) end

--- Return joint limits for hinge or prismatic joint. Returns angle or distance
--- depending on joint type.
--- ### Example
--- ```lua
--- function client.init()
--- 	local min, max = GetJointLimits(FindJoint("hinge"))
--- 	DebugPrint(min .. "-" .. max)
--- end
--- ```
--- @param joint number -- Joint handle
--- @return number min -- Minimum joint limit (angle or distance)
--- @return number max -- Maximum joint limit (angle or distance)
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetJointLimits)
function GetJointLimits(joint) end

--- Return the current position or angle or the joint, measured in same way
--- as joint limits.
--- ### Example
--- ```lua
--- function client.init()
--- 	local current = GetJointMovement(FindJoint("hinge"))
--- 	DebugPrint(current)
--- end
--- ```
--- @param joint number -- Joint handle
--- @return number movement -- Current joint position or angle
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetJointMovement)
function GetJointMovement(joint) end

--- ### Example
--- ```lua
--- local body = 0
--- function client.init()
--- 	body = FindBody("body")
--- end
--- function client.tick()
--- 	--Draw outline for all bodies in jointed structure
--- 	local all = GetJointedBodies(body)
--- 	for i=1,#all do
--- 		DrawBodyOutline(all[i], 0.5)
--- 	end
--- end
--- ```
--- @param body number -- Body handle (must be dynamic)
--- @return table bodies -- Handles to all dynamic bodies in the jointed structure. The input handle will also be included.
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetJointedBodies)
function GetJointedBodies(body) end

--- Detach joint from shape. If joint is not connected to shape, nothing happens.
--- ### Example
--- ```lua
--- function server.init()
--- 	DetachJointFromShape(FindJoint("joint"), FindShape("door"))
--- end
--- ```
--- @param joint number -- Joint handle
--- @param shape number -- Shape handle
--- [View Documentation](https://teardowngame.com/experimental/api.html#DetachJointFromShape)
function DetachJointFromShape(joint, shape) end

--- Returns the number of points in the rope given its handle.
--- Will return zero if the handle is not a rope
--- ### Example
--- ```lua
--- function client.init()
--- 	local joint = FindJoint("joint")
--- 	local numberPoints = GetRopeNumberOfPoints(joint)
--- end
--- ```
--- @param joint number -- Joint handle
--- @return number amount -- Number of points in a rope or zero if invalid
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRopeNumberOfPoints)
function GetRopeNumberOfPoints(joint) end

--- Returns the world position of the rope's point.
--- Will return nil if the handle is not a rope or the index is not valid
--- ### Example
--- ```lua
--- function client.init()
--- 	local joint = FindJoint("joint")
--- 	numberPoints = GetRopeNumberOfPoints(joint)
--- 	for pointIndex = 1, numberPoints do
--- 		DebugCross(GetRopePointPosition(joint, pointIndex))
--- 	end
--- end
--- ```
--- @param joint number -- Joint handle
--- @param index number -- The point index, starting at 1
--- @return TVec pos -- World position of the point, or nil, if invalid
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRopePointPosition)
function GetRopePointPosition(joint, index) end

--- Returns the bounds of the rope.
--- Will return nil if the handle is not a rope
--- ### Example
--- ```lua
--- function client.init()
--- 	local joint = FindJoint("joint")
--- 	local mi, ma = GetRopeBounds(joint)
--- 	DebugCross(mi)
--- 	DebugCross(ma)
--- end
--- ```
--- @param joint number -- Joint handle
--- @return TVec min -- Lower point of rope bounds in world space
--- @return TVec max -- Upper point of rope bounds in world space
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRopeBounds)
function GetRopeBounds(joint) end

--- Breaks the rope at the specified point.
--- ### Example
--- ```lua
--- function doPlayerAction(playerId)
--- 	local playerCameraTransform = GetPlayerCameraTransform(playerId)
--- 	local dir = TransformToParentVec(playerCameraTransform, Vec(0, 0, -1))
--- 	local hit, dist, joint = QueryRaycastRope(playerCameraTransform.pos, dir, 5)
--- 	if hit then
--- 		local breakPoint = VecAdd(playerCameraTransform.pos, VecScale(dir, dist))
--- 		BreakRope(joint, breakPoint)
--- 	end
--- end
--- ```
--- @param joint number -- Rope type joint handle
--- @param point TVec -- Point of break as world space vector
--- [View Documentation](https://teardowngame.com/experimental/api.html#BreakRope)
function BreakRope(joint, point) end

