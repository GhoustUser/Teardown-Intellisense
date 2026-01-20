--- @meta

--- Create new vector and optionally initializes it to the provided values.
--- A Vec is equivalent to a regular lua table with three numbers.
--- @param x? number -- X value
--- @param y? number -- Y value
--- @param z? number -- Z value
--- @return TVec vec -- New vector
--- ### Example
--- ```lua
--- function init()
--- 	--These are equivalent
--- 	local a1 = Vec()
--- 	local a2 = {0, 0, 0}
--- 	DebugPrint("a1 == a2: " .. tostring(VecStr(a1) == VecStr(a2)))
--- 	--These are equivalent
--- 	local b1 = Vec(0, 1, 0)
--- 	local b2 = {0, 1, 0}
--- 	DebugPrint("b1 == b2: " .. tostring(VecStr(b1) == VecStr(b2)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#Vec)
function Vec(x, y, z) end

--- Vectors should never be assigned like regular numbers. Since they are
--- implemented with lua tables assignment means two references pointing to
--- the same data. Use this function instead.
--- @param org TVec -- A vector
--- @return TVec new -- Copy of org vector
--- ### Example
--- ```lua
--- function init()
--- 	--Do this to assign a vector
--- 	local right1 = Vec(1, 2, 3)
--- 	local right2 = VecCopy(right1)
--- 	--Never do this unless you REALLY know what you're doing
--- 	local wrong1 = Vec(1, 2, 3)
--- 	local wrong2 = wrong1
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecCopy)
function VecCopy(org) end

--- Returns the string representation of vector
--- @param vector TVec -- Vector
--- @return string str -- String representation
--- ### Example
--- ```lua
--- function init()
--- 	local v = Vec(0, 10, 0)
--- 	DebugPrint(VecStr(v))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecStr)
function VecStr(vector) end

--- @param vec TVec -- A vector
--- @return number length -- Length (magnitude) of the vector
--- ### Example
--- ```lua
--- function init()
--- 	local v = Vec(1,1,0)
--- 	local l = VecLength(v)
--- 	--l now equals 1.4142
--- 	DebugPrint(l)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecLength)
function VecLength(vec) end

--- If the input vector is of zero length, the function returns {0,0,1}
--- @param vec TVec -- A vector
--- @return TVec norm -- A vector of length 1.0
--- ### Example
--- ```lua
--- function init()
--- 	local v = Vec(0,3,0)
--- 	local n = VecNormalize(v)
--- 	--n now equals {0,1,0}
--- 	DebugPrint(VecStr(n))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecNormalize)
function VecNormalize(vec) end

--- @param vec TVec -- A vector
--- @param scale number -- A scale factor
--- @return TVec norm -- A scaled version of input vector
--- ### Example
--- ```lua
--- function init()
--- 	local v = Vec(1,2,3)
--- 	local n = VecScale(v, 2)
--- 	--n now equals {2,4,6}
--- 	DebugPrint(VecStr(n))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecScale)
function VecScale(vec, scale) end

--- @param a TVec -- Vector
--- @param b TVec -- Vector
--- @return TVec c -- New vector with sum of a and b
--- ### Example
--- ```lua
--- function init()
--- 	local a = Vec(1,2,3)
--- 	local b = Vec(3,0,0)
--- 	local c = VecAdd(a, b)
--- 	--c now equals {4,2,3}
--- 	DebugPrint(VecStr(c))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecAdd)
function VecAdd(a, b) end

--- @param a TVec -- Vector
--- @param b TVec -- Vector
--- @return TVec c -- New vector representing a-b
--- ### Example
--- ```lua
--- function init()
--- 	local a = Vec(1,2,3)
--- 	local b = Vec(3,0,0)
--- 	local c = VecSub(a, b)
--- 	--c now equals {-2,2,3}
--- 	DebugPrint(VecStr(c))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecSub)
function VecSub(a, b) end

--- @param a TVec -- Vector
--- @param b TVec -- Vector
--- @return number c -- Dot product of a and b
--- ### Example
--- ```lua
--- function init()
--- 	local a = Vec(1,2,3)
--- 	local b = Vec(3,1,0)
--- 	local c = VecDot(a, b)
--- 	--c now equals 5
--- 	DebugPrint(c)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecDot)
function VecDot(a, b) end

--- @param a TVec -- Vector
--- @param b TVec -- Vector
--- @return TVec c -- Cross product of a and b (also called vector product)
--- ### Example
--- ```lua
--- function init()
--- 	local a = Vec(1,0,0)
--- 	local b = Vec(0,1,0)
--- 	local c = VecCross(a, b)
--- 	--c now equals {0,0,1}
--- 	DebugPrint(VecStr(c))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecCross)
function VecCross(a, b) end

--- @param a TVec -- Vector
--- @param b TVec -- Vector
--- @param t number -- fraction (usually between 0.0 and 1.0)
--- @return TVec c -- Linearly interpolated vector between a and b, using t
--- ### Example
--- ```lua
--- function init()
--- 	local a = Vec(2,0,0)
--- 	local b = Vec(0,4,2)
--- 	local t = 0.5
--- 	--These two are equivalent
--- 	local c1 = VecLerp(a, b, t)
--- 	local c2 = VecAdd(VecScale(a, 1-t), VecScale(b, t))
--- 	--c1 and c2 now equals {1, 2, 1}
--- 	DebugPrint("c1" .. VecStr(c1) .. " == c2" .. VecStr(c2))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#VecLerp)
function VecLerp(a, b, t) end

--- Create new quaternion and optionally initializes it to the provided values.
--- Do not attempt to initialize a quaternion with raw values unless you know
--- what you are doing. Use QuatEuler or QuatAxisAngle instead.
--- If no arguments are given, a unit quaternion will be created: {0, 0, 0, 1}.
--- A quaternion is equivalent to a regular lua table with four numbers.
--- @param x? number -- X value
--- @param y? number -- Y value
--- @param z? number -- Z value
--- @param w? number -- W value
--- @return TQuat quat -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	--These are equivalent
--- 	local a1 = Quat()
--- 	local a2 = {0, 0, 0, 1}
--- 	DebugPrint(QuatStr(a1) == QuatStr(a2))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#Quat)
function Quat(x, y, z, w) end

--- Quaternions should never be assigned like regular numbers. Since they are
--- implemented with lua tables assignment means two references pointing to
--- the same data. Use this function instead.
--- @param org TQuat -- Quaternion
--- @return TQuat new -- Copy of org quaternion
--- ### Example
--- ```lua
--- function init()
--- 	--Do this to assign a quaternion
--- 	local right1 = QuatEuler(0, 90, 0)
--- 	local right2 = QuatCopy(right1)
--- 	--Never do this unless you REALLY know what you're doing
--- 	local wrong1 = QuatEuler(0, 90, 0)
--- 	local wrong2 = wrong1
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatCopy)
function QuatCopy(org) end

--- Create a quaternion representing a rotation around a specific axis
--- @param axis TVec -- Rotation axis, unit vector
--- @param angle number -- Rotation angle in degrees
--- @return TQuat quat -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	--Create quaternion representing rotation 30 degrees around Y axis
--- 	local q = QuatAxisAngle(Vec(0,1,0), 30)
--- 	DebugPrint(QuatStr(q))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatAxisAngle)
function QuatAxisAngle(axis, angle) end

--- Create a quaternion representing a rotation between the input normals
--- @param normal0 TVec -- Unit vector
--- @param normal1 TVec -- Unit vector
--- @return TQuat quat -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	--Create quaternion representing a rotation between x-axis and y-axis
--- 	local q = QuatDeltaNormals(Vec(1,0,0), Vec(0,1,0))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatDeltaNormals)
function QuatDeltaNormals(normal0, normal1) end

--- Create a quaternion representing a rotation between the input vectors that doesn't need to be of unit-length
--- @param vector0 TVec -- Vector
--- @param vector1 TVec -- Vector
--- @return TQuat quat -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	--Create quaternion representing a rotation between two non-unit vectors aligned along x-axis and y-axis
--- 	local q = QuatDeltaVectors(Vec(10,0,0), Vec(0,5,0))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatDeltaVectors)
function QuatDeltaVectors(vector0, vector1) end

--- @param x number -- Angle around X axis in degrees, sometimes also called roll or bank
--- @param y number -- Angle around Y axis in degrees, sometimes also called yaw or heading
--- @param z number -- Angle around Z axis in degrees, sometimes also called pitch or attitude
--- @return TQuat quat -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	--Create quaternion representing rotation 30 degrees around Y axis and 25 degrees around Z axis
--- 	local q = QuatEuler(0, 30, 25)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatEuler)
function QuatEuler(x, y, z) end

--- Return the quaternion aligned to specified axes
--- @param xAxis TVec -- X axis
--- @param zAxis TVec -- Z axis
--- @return TQuat quat -- Quaternion
--- ### Example
--- ```lua
--- function update()
--- 	local laserSprite = LoadSprite("gfx/laser.png")
--- 	local origin = Vec(0, 0, 0)
--- 	local dir = Vec(1, 0, 0)
--- 	local length = 10
--- 	local hitPoint = VecAdd(origin, VecScale(dir, length))
--- 	local t = Transform(VecLerp(origin, hitPoint, 0.5))
--- 	local xAxis = VecNormalize(VecSub(hitPoint, origin))
--- 	local zAxis = VecNormalize(VecSub(origin, GetCameraTransform().pos))
--- 	t.rot = QuatAlignXZ(xAxis, zAxis)
--- 	DrawSprite(laserSprite, t, length, 0.05+math.random()*0.01, 8, 4, 4, 1, true, true)
--- 	DrawSprite(laserSprite, t, length, 0.5, 1.0, 0.3, 0.3, 1, true, true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatAlignXZ)
function QuatAlignXZ(xAxis, zAxis) end

--- @param quat TQuat -- Quaternion
--- @return number x -- Angle around X axis in degrees, sometimes also called roll or bank
--- @return number y -- Angle around Y axis in degrees, sometimes also called yaw or heading
--- @return number z -- Angle around Z axis in degrees, sometimes also called pitch or attitude
--- ### Example
--- ```lua
--- function init()
--- 	--Return euler angles from quaternion q
--- 	q = QuatEuler(30, 45, 0)
--- 	rx, ry, rz = GetQuatEuler(q)
--- 	DebugPrint(rx .. " " .. ry .. " " .. rz)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetQuatEuler)
function GetQuatEuler(quat) end

--- Create a quaternion pointing the negative Z axis (forward) towards
--- a specific point, keeping the Y axis upwards. This is very useful
--- for creating camera transforms.
--- @param eye TVec -- Vector representing the camera location
--- @param target TVec -- Vector representing the point to look at
--- @return TQuat quat -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	local eye = Vec(0, 10, 0)
--- 	local target = Vec(0, 1, 5)
--- 	local rot = QuatLookAt(eye, target)
--- 	SetCameraTransform(Transform(eye, rot))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatLookAt)
function QuatLookAt(eye, target) end

--- Spherical, linear interpolation between a and b, using t. This is
--- very useful for animating between two rotations.
--- @param a TQuat -- Quaternion
--- @param b TQuat -- Quaternion
--- @param t number -- fraction (usually between 0.0 and 1.0)
--- @return TQuat c -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	local a = QuatEuler(0, 10, 0)
--- 	local b = QuatEuler(0, 0, 45)
--- 	--Create quaternion half way between a and b
--- 	local q = QuatSlerp(a, b, 0.5)
--- 	DebugPrint(QuatStr(q))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatSlerp)
function QuatSlerp(a, b, t) end

--- Returns the string representation of quaternion
--- @param quat TQuat -- Quaternion
--- @return string str -- String representation
--- ### Example
--- ```lua
--- function init()
--- 	local q = QuatEuler(0, 10, 0)
--- 	DebugPrint(QuatStr(q))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatStr)
function QuatStr(quat) end

--- Rotate one quaternion with another quaternion. This is mathematically
--- equivalent to c = a * b using quaternion multiplication.
--- @param a TQuat -- Quaternion
--- @param b TQuat -- Quaternion
--- @return TQuat c -- New quaternion
--- ### Example
--- ```lua
--- function init()
--- 	local a = QuatEuler(0, 10, 0)
--- 	local b = QuatEuler(0, 0, 45)
--- 	local q = QuatRotateQuat(a, b)
--- 	--q now represents a rotation first 10 degrees around
--- 	--the Y axis and then 45 degrees around the Z axis.
--- 	local x, y, z = GetQuatEuler(q)
--- 	DebugPrint(x .. " " .. y .. " " .. z)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatRotateQuat)
function QuatRotateQuat(a, b) end

--- Rotate a vector by a quaternion
--- @param a TQuat -- Quaternion
--- @param vec TVec -- Vector
--- @return TVec vec -- Rotated vector
--- ### Example
--- ```lua
--- function init()
--- 	local q = QuatEuler(0, 10, 0)
--- 	local v = Vec(1, 0, 0)
--- 	local r = QuatRotateVec(q, v)
--- 	--r is now vector a rotated 10 degrees around the Y axis
--- 	DebugPrint(VecStr(r))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#QuatRotateVec)
function QuatRotateVec(a, vec) end

--- A transform is a regular lua table with two entries: pos and rot,
--- a vector and quaternion representing transform position and rotation.
--- @param pos? TVec -- Vector representing transform position
--- @param rot? TQuat -- Quaternion representing transform rotation
--- @return TTransform transform -- New transform
--- ### Example
--- ```lua
--- function init()
--- 	--Create transform located at {0, 0, 0} with no rotation
--- 	local t1 = Transform()
--- 	--Create transform located at {10, 0, 0} with no rotation
--- 	local t2 = Transform(Vec(10, 0,0))
--- 	--Create transform located at {10, 0, 0}, rotated 45 degrees around Y axis
--- 	local t3 = Transform(Vec(10, 0,0), QuatEuler(0, 45, 0))
--- 	DebugPrint(TransformStr(t1))
--- 	DebugPrint(TransformStr(t2))
--- 	DebugPrint(TransformStr(t3))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#Transform)
function Transform(pos, rot) end

--- Transforms should never be assigned like regular numbers. Since they are
--- implemented with lua tables assignment means two references pointing to
--- the same data. Use this function instead.
--- @param org TTransform -- Transform
--- @return TTransform new -- Copy of org transform
--- ### Example
--- ```lua
--- function init()
--- 	--Do this to assign a quaternion
--- 	local right1 = Transform(Vec(1,0,0), QuatEuler(0, 90, 0))
--- 	local right2 = TransformCopy(right1)
--- 	--Never do this unless you REALLY know what you're doing
--- 	local wrong1 = Transform(Vec(1,0,0), QuatEuler(0, 90, 0))
--- 	local wrong2 = wrong1
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformCopy)
function TransformCopy(org) end

--- Returns the string representation of transform
--- @param transform TTransform -- Transform
--- @return string str -- String representation
--- ### Example
--- ```lua
--- function init()
--- 	local eye = Vec(0, 10, 0)
--- 	local target = Vec(0, 1, 5)
--- 	local rot = QuatLookAt(eye, target)
--- 	local t = Transform(eye, rot)
--- 	DebugPrint(TransformStr(t))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformStr)
function TransformStr(transform) end

--- Transform child transform out of the parent transform.
--- This is the opposite of TransformToLocalTransform.
--- @param parent TTransform -- Transform
--- @param child TTransform -- Transform
--- @return TTransform transform -- New transform
--- ### Example
--- ```lua
--- function init()
--- 	local b = GetBodyTransform(body)
--- 	local s = GetShapeLocalTransform(shape)
--- 	--b represents the location of body in world space
--- 	--s represents the location of shape in body space
--- 	local w = TransformToParentTransform(b, s)
--- 	--w now represents the location of shape in world space
--- 	DebugPrint(TransformStr(w))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformToParentTransform)
function TransformToParentTransform(parent, child) end

--- Transform one transform into the local space of another transform.
--- This is the opposite of TransformToParentTransform.
--- @param parent TTransform -- Transform
--- @param child TTransform -- Transform
--- @return TTransform transform -- New transform
--- ### Example
--- ```lua
--- function init()
--- 	local b = GetBodyTransform(body)
--- 	local w = GetShapeWorldTransform(shape)
--- 	--b represents the location of body in world space
--- 	--w represents the location of shape in world space
--- 	local s = TransformToLocalTransform(b, w)
--- 	--s now represents the location of shape in body space.
--- 	DebugPrint(TransformStr(s))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformToLocalTransform)
function TransformToLocalTransform(parent, child) end

--- Transfom vector v out of transform t only considering rotation.
--- @param t TTransform -- Transform
--- @param v TVec -- Vector
--- @return TVec r -- Transformed vector
--- ### Example
--- ```lua
--- function init()
--- 	local t = GetBodyTransform(body)
--- 	local localUp = Vec(0, 1, 0)
--- 	local up = TransformToParentVec(t, localUp)
--- 	--up now represents the local body up direction in world space
--- 	DebugPrint(VecStr(up))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformToParentVec)
function TransformToParentVec(t, v) end

--- Transfom vector v into transform t only considering rotation.
--- @param t TTransform -- Transform
--- @param v TVec -- Vector
--- @return TVec r -- Transformed vector
--- ### Example
--- ```lua
--- function init()
--- 	local t = GetBodyTransform(body)
--- 	local localUp = Vec(0, 1, 0)
--- 	local up = TransformToParentVec(t, localUp)
--- 	--up now represents the local body up direction in world space
--- 	DebugPrint(VecStr(up))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformToLocalVec)
function TransformToLocalVec(t, v) end

--- Transfom position p out of transform t.
--- @param t TTransform -- Transform
--- @param p TVec -- Vector representing position
--- @return TVec r -- Transformed position
--- ### Example
--- ```lua
--- function init()
--- 	local t = GetBodyTransform(body)
--- 	local bodyPoint = Vec(0, 0, -1)
--- 	local p = TransformToParentPoint(t, bodyPoint)
--- 	--p now represents the local body point {0, 0, -1 } in world space
--- 	DebugPrint(VecStr(p))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformToParentPoint)
function TransformToParentPoint(t, p) end

--- Transfom position p into transform t.
--- @param t TTransform -- Transform
--- @param p TVec -- Vector representing position
--- @return TVec r -- Transformed position
--- ### Example
--- ```lua
--- function init()
--- 	local t = GetBodyTransform(body)
--- 	local worldOrigo = Vec(0, 0, 0)
--- 	local p = TransformToLocalPoint(t, worldOrigo)
--- 	--p now represents the position of world origo in local body space
--- 	DebugPrint(VecStr(p))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TransformToLocalPoint)
function TransformToLocalPoint(t, p) end

--- @param seed number -- Random seed
--- ### Example
--- ```lua
--- function init()
--- 	SetRandomSeed(42)
--- 	result = RollDie()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRandomSeed)
function SetRandomSeed(seed) end

--- @return boolean result -- Random true/false
--- ### Example
--- ```lua
--- function init()
--- 	isHeads = GetRandomBool()
--- 	if isHeads then
--- 		win = true
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRandomBool)
function GetRandomBool() end

--- @param min number -- Lower number
--- @param max number -- Upper number
--- @return number result -- Random number in given range, including max.
--- ### Example
--- ```lua
--- function init()
--- 	dieRoll = GetRandomInt(1,6)
--- 	-- dieRoll is 1,2,3,4,5 or 6
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRandomInt)
function GetRandomInt(min, max) end

--- @param min number -- Lower number
--- @param max number -- Upper number
--- @return number result -- Random number in given range, including max.
--- ### Example
--- ```lua
--- function init()
--- 	-- Generate a random angle in range [0, 360]
--- 	randomAngleDeg = GetRandomFloat(0.0f, 360.0f)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRandomFloat)
function GetRandomFloat(min, max) end

--- @param length? number -- Optional length use to scale the generated direction.
--- @return Vec3 vector -- Random direction with unit length
--- ### Example
--- ```lua
--- function init()
--- 	-- Generate a random direction.
--- 	ricochetDirection = GetRandomDirection()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRandomDirection)
function GetRandomDirection(length) end

