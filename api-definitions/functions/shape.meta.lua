--- @meta


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first shape with specified tag or zero if not found
--- ### Example
--- ```lua
--- local target = 0
--- local escape = 0
--- function client.init()
--- 	--Search for a shape tagged "mybox" in script scope
--- 	target = FindShape("mybox")
--- 	--Search for a shape tagged "laserturret" in entire scene
--- 	escape = FindShape("laserturret", true)
--- end
--- function client.tick()
--- 	DebugCross(GetShapeWorldTransform(target).pos)
--- 	DebugCross(GetShapeWorldTransform(escape).pos)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindShape)
function FindShape(tag, global) end

--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return table list -- Indexed table with handles to all shapes with specified tag
--- ### Example
--- ```lua
--- local shapes = {}
--- function client.init()
--- 	--Search for shapes tagged "body"
--- 	shapes = FindShapes("body", true)
--- end
--- function client.tick()
--- 	for i=1, #shapes do
--- 		local shape = shapes[i]
--- 		DebugCross(GetShapeWorldTransform(shape).pos)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindShapes)
function FindShapes(tag, global) end

--- @param handle number -- Shape handle
--- @return TTransform transform -- Return shape transform in body space
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape")
--- end
--- function client.tick()
--- 	--Shape transform in body local space
--- 	local shapeTransform = GetShapeLocalTransform(shape)
--- 	--Body transform in world space
--- 	local bodyTransform = GetBodyTransform(GetShapeBody(shape))
--- 	--Shape transform in world space
--- 	local worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
--- 	DebugCross(worldTranform)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeLocalTransform)
function GetShapeLocalTransform(handle) end

--- @param handle number -- Shape handle
--- @param transform TTransform -- Shape transform in body space
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	shape = FindShape("shape")
--- 	local transform = Transform(Vec(0, 1, 0), QuatEuler(0, 90, 0))
--- 	SetShapeLocalTransform(shape, transform)
--- end
--- function client.init()
--- 	shape = FindShape("shape")
--- end
--- function client.tick()
--- 	--Shape transform in body local space
--- 	local shapeTransform = GetShapeLocalTransform(shape)
--- 	--Body transform in world space
--- 	local bodyTransform = GetBodyTransform(GetShapeBody(shape))
--- 	--Shape transform in world space
--- 	local worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
--- 	DebugCross(worldTranform)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetShapeLocalTransform)
function SetShapeLocalTransform(handle, transform) end

--- This is a convenience function, transforming the shape out of body space
--- @param handle number -- Shape handle
--- @return TTransform transform -- Return shape transform in world space
--- ### Example
--- ```lua
--- --GetShapeWorldTransform is equivalent to
--- --local shapeTransform = GetShapeLocalTransform(shape)
--- --local bodyTransform = GetBodyTransform(GetShapeBody(shape))
--- --worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	DebugCross(GetShapeWorldTransform(shape).pos)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeWorldTransform)
function GetShapeWorldTransform(handle) end

--- Get handle to the body this shape is owned by. A shape is always owned by a body,
--- but can be transfered to a new body during destruction.
--- @param handle number -- Shape handle
--- @return number handle -- Body handle
--- ### Example
--- ```lua
--- local body = 0
--- function client.init()
--- 	body = GetShapeBody(FindShape("shape", true))
--- end
--- function client.tick()
--- 	DebugCross(GetBodyCenterOfMass(body))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeBody)
function GetShapeBody(handle) end

--- @param shape number -- Shape handle
--- @return table list -- Indexed table with joints connected to shape
--- ### Example
--- ```lua
--- function printJoints()
--- 	local shape = FindShape("shape", true)
--- 	local hinges = GetShapeJoints(shape)
--- 	for i=1, #hinges do
--- 		local joint = hinges[i]
--- 		DebugPrint(joint)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeJoints)
function GetShapeJoints(shape) end

--- @param shape number -- Shape handle
--- @return table list -- Indexed table of lights owned by shape
--- ### Example
--- ```lua
--- function printLights()
--- 	--Print all lights owned by a shape
--- 	local shape = FindShape("shape", true)
--- 	local light = GetShapeLights(shape)
--- 	for i=1, #light do
--- 		DebugPrint(light[i])
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeLights)
function GetShapeLights(shape) end

--- Return the world space, axis-aligned bounding box for a shape.
--- @param handle number -- Shape handle
--- @return TVec min -- Vector representing the AABB lower bound
--- @return TVec max -- Vector representing the AABB upper bound
--- ### Example
--- ```lua
--- function printShapeBounds()
--- 	local shape = FindShape("shape", true)
--- 	local min, max = GetShapeBounds(shape)
--- 	local boundsSize = VecSub(max, min)
--- 	local center = VecLerp(min, max, 0.5)
--- 	DebugPrint(VecStr(boundsSize) .. " " .. VecStr(center))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeBounds)
function GetShapeBounds(handle) end

--- Scale emissiveness for shape. If the shape has light sources attached,
--- their intensity will be scaled by the same amount.
--- @param handle number -- Shape handle
--- @param scale number -- Scale factor for emissiveness
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	shape = FindShape("shape", true)
--- 	--Pulsate emissiveness and light intensity for shape
--- 	local scale = math.sin(GetTime())*0.5 + 0.5
--- 	SetShapeEmissiveScale(shape, scale)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetShapeEmissiveScale)
function SetShapeEmissiveScale(handle, scale) end

--- Change the material density of the shape.
--- @param handle number -- Shape handle
--- @param density number -- New density for the shape
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	shape = FindShape("shape", true)
--- 	local density = 10.0
--- 	SetShapeDensity(shape, density)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetShapeDensity)
function SetShapeDensity(handle, density) end

--- Return material properties for a particular voxel
--- @param handle number -- Shape handle
--- @param pos TVec -- Position in world space
--- @param includeUnphysical? boolean -- Include unphysical voxels in the search. Default false.
--- @return string type -- Material type
--- @return number r -- Red
--- @return number g -- Green
--- @return number b -- Blue
--- @return number a -- Alpha
--- @return number entry -- Palette entry for voxel (zero if empty)
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	local pos = GetCameraTransform().pos
--- 	local dir = Vec(0, 0, 1)
--- 	local hit, dist, normal, shape = QueryRaycast(pos, dir, 10)
--- 	if hit then
--- 		local hitPoint = VecAdd(pos, VecScale(dir, dist))
--- 		local mat = GetShapeMaterialAtPosition(shape, hitPoint)
--- 		DebugPrint("Raycast hit voxel made out of " .. mat)
--- 	end
--- 	DebugLine(pos, VecAdd(pos, VecScale(dir, 10)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeMaterialAtPosition)
function GetShapeMaterialAtPosition(handle, pos, includeUnphysical) end

--- Return material properties for a particular voxel in the voxel grid indexed by integer values.
--- The first index is zero (not one, as opposed to a lot of lua related things)
--- @param handle number -- Shape handle
--- @param x number -- X integer coordinate
--- @param y number -- Y integer coordinate
--- @param z number -- Z integer coordinate
--- @return string type -- Material type
--- @return number r -- Red
--- @return number g -- Green
--- @return number b -- Blue
--- @return number a -- Alpha
--- @return number entry -- Palette entry for voxel (zero if empty)
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- 	local mat = GetShapeMaterialAtIndex(shape, 0, 0, 0)
--- 	DebugPrint("The voxel is of material: " .. mat)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeMaterialAtIndex)
function GetShapeMaterialAtIndex(handle, x, y, z) end

--- Return the size of a shape in voxels
--- @param handle number -- Shape handle
--- @return number xsize -- Size in voxels along x axis
--- @return number ysize -- Size in voxels along y axis
--- @return number zsize -- Size in voxels along z axis
--- @return number scale -- The size of one voxel in meters (with default scale it is 0.1)
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- 	local x, y, z = GetShapeSize(shape)
--- 	DebugPrint("Shape size: " .. x .. ";" .. y .. ";" .. z)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeSize)
function GetShapeSize(handle) end

--- Return the number of voxels in a shape, not including empty space
--- @param handle number -- Shape handle
--- @return number count -- Number of voxels in shape
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- 	local voxelCount = GetShapeVoxelCount(shape)
--- 	DebugPrint(voxelCount)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeVoxelCount)
function GetShapeVoxelCount(handle) end

--- This function does a very rudimetary check and will only return true if the 
--- object is visible within 74 degrees of the camera's forward direction, and
--- only tests line-of-sight visibility for the corners and center of the bounding box.
--- @param handle number -- Shape handle
--- @param maxDist number -- Maximum visible distance
--- @param rejectTransparent? boolean -- See through transparent materials. Default false.
--- @param playerId? number -- Player ID. On client, zero means client player. On server, zero means server(host) player.
--- @return boolean visible -- Return true if shape is visible
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	if IsShapeVisible(shape, 25) then
--- 		DebugPrint("Shape is visible")
--- 	else
--- 		DebugPrint("Shape is not visible")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsShapeVisible)
function IsShapeVisible(handle, maxDist, rejectTransparent, playerId) end

--- Determine if shape has been broken. Note that a shape can be transfered
--- to another body during destruction, but might still not be considered
--- broken if all voxels are intact.
--- @param handle number -- Shape handle
--- @return boolean broken -- Return true if shape is broken
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	DebugPrint("Is shape broken: " .. tostring(IsShapeBroken(shape)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsShapeBroken)
function IsShapeBroken(handle) end

--- Render next frame with an outline around specified shape.
--- If no color is given, a white outline will be drawn.
--- @param handle number -- Shape handle
--- @param r? number -- Red
--- @param g? number -- Green
--- @param b? number -- Blue
--- @param a number -- Alpha
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	if InputDown("interact") then
--- 		--Draw white outline at 50% transparency
--- 		DrawShapeOutline(shape, 0.5)
--- 	else
--- 		--Draw green outline, fully opaque
--- 		DrawShapeOutline(shape, 0, 1, 0, 1)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawShapeOutline)
function DrawShapeOutline(handle, r, g, b, a) end

--- Flash the appearance of a shape when rendering this frame.
--- @param handle number -- Shape handle
--- @param amount number -- Amount
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	if InputDown("interact") then
--- 		DrawShapeHighlight(shape, 0.5)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawShapeHighlight)
function DrawShapeHighlight(handle, amount) end

--- This is used to filter out collisions with other shapes. Each shape can be given a layer
--- bitmask (8 bits, 0-255) along with a mask (also 8 bits). The layer of one object must be in
--- the mask of the other object and vice versa for the collision to be valid. The default layer
--- for all objects is 1 and the default mask is 255 (collide with all layers).
--- @param handle number -- Shape handle
--- @param layer number -- Layer bits (0-255)
--- @param mask number -- Mask bits (0-255)
--- ### Example
--- ```lua
--- local shapeA = 0
--- local shapeB = 0
--- local shapeC = 0
--- local shapeD = 0
--- function server.init()
--- 	shapeA = FindShape("shapeA")
--- 	shapeB = FindShape("shapeB")
--- 	shapeC = FindShape("shapeC")
--- 	shapeD = FindShape("shapeD")
--- 	--This will put shapes a and b in layer 2 and disable collisions with
--- 	--object shapes in layers 2, preventing any collisions between the two.
--- 	SetShapeCollisionFilter(shapeA, 2, 255-2)
--- 	SetShapeCollisionFilter(shapeB, 2, 255-2)
--- 	--This will put shapes c and d in layer 4 and allow collisions with other
--- 	--shapes in layer 4, but ignore all other collisions with the rest of the world.
--- 	SetShapeCollisionFilter(shapeC, 4, 4)
--- 	SetShapeCollisionFilter(shapeD, 4, 4)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetShapeCollisionFilter)
function SetShapeCollisionFilter(handle, layer, mask) end

--- Returns the current layer/mask settings of the shape
--- @param handle number -- Shape handle
--- @return number layer -- Layer bits (0-255)
--- @return number mask -- Mask bits (0-255)
--- ### Example
--- ```lua
--- function server.init()
--- 	local shape = FindShape("some_shape")
--- 	local layer, mask = GetShapeCollisionFilter(shape)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeCollisionFilter)
function GetShapeCollisionFilter(handle) end

--- Create new, empty shape on existing body using the palette of a reference shape.
--- The reference shape can be any existing shape in the scene or an external vox file.
--- The size of the new shape will be 1x1x1.
--- @param body number -- Body handle
--- @param transform TTransform -- Shape transform in body space
--- @param refShape number or string -- Handle to reference shape or path to vox file
--- @return number newShape -- Handle of new shape
--- ### Example
--- ```lua
--- server.tick()
--- 	local players = GetAllPlayers()
--- 	for i=1, #players do
--- 		tickPlayer(players[i])
--- 	end
--- end
--- function tickPlayer(playerId)
--- 	if InputPressed("interact", playerId) then
--- 		local t = Transform(Vec(0, 5, 0), QuatEuler(0, 0, 0))
--- 		local handle = CreateShape(FindBody("shape", true), t, FindShape("shape", true))
--- 		DebugPrint(handle)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#CreateShape)
function CreateShape(body, transform, refShape) end

--- Fill a voxel shape with zeroes, thus removing all voxels.
--- @param shape number -- Shape handle
--- ### Example
--- ```lua
--- function server.init()
--- 	ClearShape(FindShape("shape", true))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ClearShape)
function ClearShape(shape) end

--- Resize an existing shape. The new coordinates are expressed in the existing shape coordinate frame,
--- so you can provide negative values. The existing content is preserved, but may be cropped if needed.
--- The local shape transform will be moved automatically with an offset vector to preserve the original content in body space.
--- This offset vector is returned in shape local space.
--- @param shape number -- Shape handle
--- @param xmi number -- Lower X coordinate
--- @param ymi number -- Lower Y coordinate
--- @param zmi number -- Lower Z coordinate
--- @param xma number -- Upper X coordinate
--- @param yma number -- Upper Y coordinate
--- @param zma number -- Upper Z coordinate
--- @return boolean resized -- Resized successfully
--- @return TVec offset -- Offset vector in shape local space
--- ### Example
--- ```lua
--- function server.init()
--- 	ResizeShape(FindShape("shape", true), -5, 0, -5, 5, 5, 5)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ResizeShape)
function ResizeShape(shape, xmi, ymi, zmi, xma, yma, zma) end

--- Move existing shape to a new body, optionally providing a new local transform.
--- @param shape number -- Shape handle
--- @param body number -- Body handle
--- @param transform? TTransform -- New local shape transform. Default is existing local transform.
--- ### Example
--- ```lua
--- function server.init()
--- 	SetShapeBody(FindShape("shape", true), FindBody("custombody", true), true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetShapeBody)
function SetShapeBody(shape, body, transform) end

--- Copy voxel content from source shape to destination shape. If destination
--- shape has a different size, it will be resized to match the source shape.
--- @param src number -- Source shape handle
--- @param dst number -- Destination shape handle
--- ### Example
--- ```lua
--- function server.init()
--- 	CopyShapeContent(FindShape("shape", true), FindShape("shape2", true))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#CopyShapeContent)
function CopyShapeContent(src, dst) end

--- Copy the palette from source shape to destination shape.
--- @param src number -- Source shape handle
--- @param dst number -- Destination shape handle
--- ### Example
--- ```lua
--- function server.init()
--- 	CopyShapePalette(FindShape("shape", true), FindShape("shape2", true))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#CopyShapePalette)
function CopyShapePalette(src, dst) end

--- Return list of material entries, each entry is a material index that
--- can be provided to GetShapeMaterial or used as brush for populating a
--- shape.
--- @param shape number -- Shape handle
--- @return table entries -- Palette material entries
--- ### Example
--- ```lua
--- function server.init()
--- 	local palette = GetShapePalette(FindShape("shape2", true))
--- 	for i = 1, #palette do
--- 		DebugPrint(palette[i])
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapePalette)
function GetShapePalette(shape) end

--- Return material properties for specific matirial entry.
--- @param shape number -- Shape handle
--- @param entry number -- Material entry
--- @return string type -- Type
--- @return number red -- Red value
--- @return number green -- Green value
--- @return number blue -- Blue value
--- @return number alpha -- Alpha value
--- @return number reflectivity -- Range 0 to 1
--- @return number shininess -- Range 0 to 1
--- @return number metallic -- Range 0 to 1
--- @return number emissive -- Range 0 to 32
--- ### Example
--- ```lua
--- function client.init()
--- 	local type, r, g, b, a, reflectivity, shininess, metallic, emissive = GetShapeMaterial(FindShape("shape2", true), 1)
--- 	DebugPrint(type)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeMaterial)
function GetShapeMaterial(shape, entry) end

--- Set material index to be used for following calls to DrawShapeLine and DrawShapeBox and ExtrudeShape.
--- An optional brush vox file and subobject can be used and provided instead of material index,
--- in which case the content of the brush will be used and repeated. Use material index zero
--- to remove of voxels.
--- @param type string -- One of "sphere", "cube" or "noise"
--- @param size number -- Size of brush in voxels (must be in range 1 to 16)
--- @param indexOrPath number or string -- Material index or path to brush vox file
--- @param object? string -- Optional object in brush vox file if brush vox file is used
--- ### Example
--- ```lua
--- function server.init()
--- 	SetBrush("sphere", 3, 3)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetBrush)
function SetBrush(type, size, indexOrPath, object) end

--- Draw voxelized line between (x0,y0,z0) and (x1,y1,z1) into shape using the material
--- set up with SetBrush. Paint mode will only change material of existing voxels (where
--- the current material index is non-zero). noOverwrite mode will only fill in voxels if the
--- space isn't already occupied by another shape in the scene.
--- @param shape number -- Handle to shape
--- @param x0 number -- Start X coordinate
--- @param y0 number -- Start Y coordinate
--- @param z0 number -- Start Z coordinate
--- @param x1 number -- End X coordinate
--- @param y1 number -- End Y coordinate
--- @param z1 number -- End Z coordinate
--- @param paint? boolean -- Paint mode. Default is false.
--- @param noOverwrite? boolean -- Only fill in voxels if space isn't already occupied. Default is false.
--- ### Example
--- ```lua
--- function server.init()
--- 	SetBrush("sphere", 3, 1)
--- 	DrawShapeLine(FindShape("shape"), 0, 0, 0, 10, 50, 5, false, true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawShapeLine)
function DrawShapeLine(shape, x0, y0, z0, x1, y1, z1, paint, noOverwrite) end

--- Draw box between (x0,y0,z0) and (x1,y1,z1) into shape using the material
--- set up with SetBrush.
--- @param shape number -- Handle to shape
--- @param x0 number -- Start X coordinate
--- @param y0 number -- Start Y coordinate
--- @param z0 number -- Start Z coordinate
--- @param x1 number -- End X coordinate
--- @param y1 number -- End Y coordinate
--- @param z1 number -- End Z coordinate
--- ### Example
--- ```lua
--- function server.init()
--- 	SetBrush("sphere", 3, 4)
--- 	DrawShapeBox(FindShape("shape", true), 0, 0, 0, 10, 50, 5)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawShapeBox)
function DrawShapeBox(shape, x0, y0, z0, x1, y1, z1) end

--- Extrude region of shape. The extruded region will be filled in with the material set up with SetBrush.
--- The mode parameter sepcifies how the region is determined.
--- Exact mode selects region of voxels that exactly match the input voxel at input coordinate.
--- Material mode selects region that has the same material type as the input voxel.
--- Geometry mode selects any connected voxel in the same plane as the input voxel.
--- @param shape number -- Handle to shape
--- @param x number -- X coordinate to extrude
--- @param y number -- Y coordinate to extrude
--- @param z number -- Z coordinate to extrude
--- @param dx number -- X component of extrude direction, should be -1, 0 or 1
--- @param dy number -- Y component of extrude direction, should be -1, 0 or 1
--- @param dz number -- Z component of extrude direction, should be -1, 0 or 1
--- @param steps number -- Length of extrusion in voxels
--- @param mode string -- Extrusion mode, one of "exact", "material", "geometry". Default is "exact"
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	SetBrush("sphere", 3, 4)
--- 	shape = FindShape("shape")
--- 	ExtrudeShape(shape, 0, 5, 0, -1, 0, 0, 50, "exact")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ExtrudeShape)
function ExtrudeShape(shape, x, y, z, dx, dy, dz, steps, mode) end

--- Trim away empty regions of shape, thus potentially making it smaller.
--- If the size of the shape changes, the shape will be automatically moved
--- to preserve the shape content in body space. The offset vector for this
--- translation is returned in shape local space.
--- @param shape number -- Source handle
--- @return TVec offset -- Offset vector in shape local space
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	shape = FindShape("shape", true)
--- 	TrimShape(shape)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#TrimShape)
function TrimShape(shape) end

--- Split up a shape into multiple shapes based on connectivity. If the removeResidual flag
--- is used, small disconnected chunks will be removed during this process to reduce the number
--- of newly created shapes.
--- @param shape number -- Source handle
--- @param removeResidual boolean -- Remove residual shapes (default false)
--- @return table newShapes -- List of shape handles created
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	shape = FindShape("shape", true)
--- 	SplitShape(shape, true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SplitShape)
function SplitShape(shape, removeResidual) end

--- Try to merge shape with a nearby, matching shape. For a merge to happen, the
--- shapes need to be aligned to the same rotation and touching. If the
--- provided shape was merged into another shape, that shape may be resized to
--- fit the merged content. If shape was merged, the handle to the other shape is
--- returned, otherwise the input handle is returned.
--- @param shape number -- Input shape
--- @return number shape -- Shape handle after merge
--- ### Example
--- ```lua
--- local shape = 0
--- function server.init()
--- 	shape = FindShape("shape", true)
--- 	DebugPrint(shape)
--- 	shape = MergeShape(shape)
--- 	DebugPrint(shape)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#MergeShape)
function MergeShape(shape) end

--- @param shape number -- Input shape
--- @return boolean disconnected -- True if shape disconnected (has detached parts)
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugWatch("IsShapeDisconnected", IsShapeDisconnected(FindShape("shape", true)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsShapeDisconnected)
function IsShapeDisconnected(shape) end

--- @param shape number -- Input shape
--- @return boolean disconnected -- True if static shape has detached parts
--- ### Example
--- ```lua
--- function client.tick()
--- 	DebugWatch("IsStaticShapeDetached", IsStaticShapeDetached(FindShape("shape_glass", true)))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsStaticShapeDetached)
function IsStaticShapeDetached(shape) end

--- This will return the closest point of a specific shape
--- @param shape number -- Shape handle
--- @param origin TVec -- World space point
--- @return boolean hit -- True if a point was found
--- @return TVec point -- World space closest point
--- @return TVec normal -- World space normal at closest point
--- ### Example
--- ```lua
--- local shape = 0
--- function client.init()
--- 	shape = FindShape("shape", true)
--- end
--- function client.tick()
--- 	DebugCross(Vec(1, 0, 0))
--- 	local hit, p, n, s = GetShapeClosestPoint(shape, Vec(1, 0, 0))
--- 	if hit then
--- 		DebugCross(p)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetShapeClosestPoint)
function GetShapeClosestPoint(shape, origin) end

--- This will check if two shapes has physical overlap
--- @param a number -- Handle to first shape
--- @param b number -- Handle to second shape
--- @return boolean touching -- True is shapes a and b are touching each other
--- ### Example
--- ```lua
--- local shapeA = 0
--- local shapeB = 0
--- function client.init()
--- 	shapeA = FindShape("shape")
--- 	shapeB = FindShape("shape2")
--- end
--- function client.tick()
--- 	DebugPrint(IsShapeTouching(shapeA, shapeB))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsShapeTouching)
function IsShapeTouching(a, b) end

