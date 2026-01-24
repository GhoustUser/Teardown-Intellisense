--- @meta


--- An Entity is the basis of most objects in the Teardown engine (bodies, shapes, lights, locations, etc). 
--- All entities can have tags, which is a way to store custom properties on entities for scripting purposes. 
--- Some tags are also reserved for engine use. See documentation for details. 


--- @alias GetProperty_EntityType
--- | 'Body' desc (string), dynamic (boolean), mass (number), transform, velocity (vector(x, y, z)), angVelocity (vector(x, y, z)), active (boolean), friction (number), restitution (number), frictionMode (average|minimum|multiply|maximum), restitutionMode (average|minimum|multiply|maximum)
--- | 'Shape' density (number), strength (number), size (number), emissiveScale (number), localTransform, worldTransform
--- | 'Light' enabled (boolean), color (vector(r, g, b)), intensity (number), transform, active (boolean), type (string), size (number), reach (number), unshadowed (number), fogscale (number), fogiter (number), glare (number)
--- | 'Location' transform
--- | 'Water' depth (number), wave (number), ripple (number), motion (number), foam (number), color (vector(r, g, b))
--- | 'Joint' type (string), size (number), rotstrength (number), rotspring (number);  only for ropes: slack (number), strength (number), maxstretch (number), ropecolor (vector(r, g, b))
--- | 'Vehicle' spring (number), damping (number), topspeed (number), acceleration (number), strength (number), antispin (number), antiroll (number), difflock (number), steerassist (number), friction (number), smokeintensity (number), transform, brokenthreshold (number)
--- | 'Wheel' drive (number), steer (number), travel (vector(x, y))
--- | 'Screen' enabled (boolean), bulge (number), resolution (number, number), script (string), interactive (boolean), emissive (number), fxraster (number), fxca (number), fxnoise (number), fxglitch (number), size (vector(x, y))
--- | 'Trigger' transform, type (string), size (vector(x, y, z)/number)

--- @alias SetProperty_EntityType
--- | 'Body' desc (string), dynamic (boolean), transform, velocity (vector(x, y, z)), angVelocity (vector(x,y,z)), active (boolean), friction (number), restitution (number), frictionMode (average|minimum|multiply|maximum), restitutionMode (average|minimum|multiply|maximum)
--- | 'Shape' density (number), strength (number), emissiveScale (number), localTransform
--- | 'Light' enabled (boolean), color (vector(r, g, b)), intensity (number), transform, size (number/vector(x,y)), reach (number), unshadowed (number), fogscale (number), fogiter (number), glare (number)
--- | 'Location' transform
--- | 'Water' type (string), depth (number), wave (number), ripple (number), motion (number), foam (number), color (vector(r, g, b))
--- | 'Joint' size (number), rotstrength (number), rotspring (number);  only for ropes: slack (number), strength (number), maxstretch (number), ropecolor (vector(r, g, b))
--- | 'Vehicle' spring (number), damping (number), topspeed (number), acceleration (number), strength (number), antispin (number), antiroll (number), difflock (number), steerassist (number), friction (number), smokeintensity (number), transform, brokenthreshold (number)
--- | 'Wheel' drive (number), steer (number), travel (vector(x, y))
--- | 'Screen' enabled (boolean), interactive (boolean), emissive (number), fxraster (number), fxca (number), fxnoise (number), fxglitch (number)
--- | 'Trigger' transform, size (vector(x, y, z)/number)

--- Returns an entity with the specified tag and type. This is a universal method that is an alternative to FindBody, FindShape, FindVehicle, etc.
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @param type? string -- Entity type ("body", "shape", "light", "location" etc.)
--- @return number handle -- Handle to first entity with specified tag or zero if not found
--- ### Example
--- ```lua
--- function client.tick()
--- 	--You may use this function in a similar way to other "Find functions" like FindBody, FindShape, FindVehicle, etc.
--- 	local myCar = FindEntity("myCar", false, "vehicle")
--- 	--If you do not specify the tag, the first element found will be returned
--- 	local joint = FindEntity("", true, "joint")
--- 	--If the type is not specified, the search will be performed for all types of entity
--- 	local target = FindEntity("target", true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindEntity)
function FindEntity(tag, global, type) end

--- Returns a list of entities with the specified tag and type. This is a universal method that is an alternative to FindBody, FindShape, FindVehicle, etc.
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @param type? string -- Entity type ("body", "shape", "light", "location" etc.)
--- @return table list -- Indexed table with handles to all entities with specified tag
--- ### Example
--- ```lua
--- function client.tick()
--- 	-- You may use this function in a similar way to other "Find functions" like FindBody, FindShape, FindVehicle, etc.
--- 	local cars = FindEntities("car", false, "vehicle")
--- 	-- You can get all the entities of the specified type by passing an empty string to the tag
--- 	local allJoints = FindEntities("", true, "joint")
--- 	-- If the type is not specified, the search will be performed for all types
--- 	local allUnbreakables = FindEntities("unbreakable", true)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindEntities)
function FindEntities(tag, global, type) end

--- Returns child entities
--- @param handle number -- Entity handle
--- @param tag? string -- Tag name
--- @param recursive? boolean -- Search recursively
--- @param type? string -- Entity type ("body", "shape", "light", "location" etc.)
--- @return table list -- Indexed table with child elements of the entity
--- ### Example
--- ```lua
--- function client.tick()
--- 	local car = FindEntity("car", true, "vehicle")
--- 	DebugWatch("car", car)
--- 	local children = GetEntityChildren(entity, "", true, "wheel")
--- 	for i = 1, #children do
--- 		DebugWatch("wheel " .. tostring(i), children[i])
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEntityChildren)
function GetEntityChildren(handle, tag, recursive, type) end

--- @param handle number -- Entity handle
--- @param tag? string -- Tag name
--- @param type? string -- Entity type ("body", "shape", "light", "location" etc.)
--- @return number handle -- 
--- ### Example
--- ```lua
--- function client.tick()
--- 	local wheel = FindEntity("", true, "wheel")
--- 	local vehicle = GetEntityParent(wheel,  "", "vehicle")
--- 	DebugWatch("Wheel vehicle", GetEntityType(vehicle) .. " " .. tostring(vehicle))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEntityParent)
function GetEntityParent(handle, tag, type) end

--- @param handle number -- Entity handle
--- @param tag string -- Tag name
--- @param value? string -- Tag value
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Add "special" tag to an entity
--- 	SetTag(handle, "special")
--- 	DebugPrint(HasTag(handle, "special"))
--- 	--Add "team" tag to an entity and give it value "red"
--- 	SetTag(handle, "team", "red")
--- 	DebugPrint(HasTag(handle, "team"))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetTag)
function SetTag(handle, tag, value) end

--- Remove tag from an entity. If the tag had a value it is removed too.
--- @param handle number -- Entity handle
--- @param tag string -- Tag name
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Add "special" tag to an entity
--- 	SetTag(handle, "special")
--- 	RemoveTag(handle, "special")
--- 	DebugPrint(HasTag(handle, "special"))
--- 	--Add "team" tag to an entity and give it value "red"
--- 	SetTag(handle, "team", "red")
--- 	DebugPrint(HasTag(handle, "team"))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#RemoveTag)
function RemoveTag(handle, tag) end

--- @param handle number -- Entity handle
--- @param tag string -- Tag name
--- @return boolean exists -- Returns true if entity has tag
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Add "special" tag to an entity
--- 	SetTag(handle, "special")
--- 	DebugPrint(HasTag(handle, "special"))
--- 	--Add "team" tag to an entity and give it value "red"
--- 	SetTag(handle, "team", "red")
--- 	DebugPrint(HasTag(handle, "team"))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#HasTag)
function HasTag(handle, tag) end

--- @param handle number -- Entity handle
--- @param tag string -- Tag name
--- @return string value -- Returns the tag value, if any. Empty string otherwise.
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Add "team" tag to an entity and give it value "red"
--- 	SetTag(handle, "team", "red")
--- 	DebugPrint(GetTagValue(handle, "team"))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetTagValue)
function GetTagValue(handle, tag) end

--- @param handle number -- Entity handle
--- @return table tags -- Indexed table of tags on entity
--- ### Example
--- ```lua
--- function init()
--- 	local handle = FindBody("body", true)
--- 	--Add "team" tag to an entity and give it value "red"
--- 	SetTag(handle, "team", "red")
--- 	--List all tags and their tag values for a particular entity
--- 	local tags = ListTags(handle)
--- 	for i=1, #tags do
--- 		DebugPrint(tags[i] .. " " .. GetTagValue(handle, tags[i]))
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#ListTags)
function ListTags(handle) end

--- All entities can have an associated description. For bodies and
--- shapes this can be provided through the editor. This function
--- retrieves that description.
--- @param handle number -- Entity handle
--- @return string description -- The description string
--- ### Example
--- ```lua
--- function init()
--- 	local body = FindBody("body", true)
--- 	DebugPrint(GetDescription(body))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetDescription)
function GetDescription(handle) end

--- All entities can have an associated description. The description for
--- bodies and shapes will show up on the HUD when looking at them.
--- @param handle number -- Entity handle
--- @param description string -- The description string
--- ### Example
--- ```lua
--- function init()
--- 	local body = FindBody("body", true)
--- 	SetDescription(body, "Target object")
--- 	DebugPrint(GetDescription(body))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetDescription)
function SetDescription(handle, description) end

--- Remove an entity from the scene. All entities owned by this entity
--- will also be removed.
--- @param handle number -- Entity handle
--- ### Example
--- ```lua
--- function init()
--- 	local body = FindBody("body", true)
--- 	--All shapes associated with body will also be removed
--- 	Delete(body)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#Delete)
function Delete(handle) end

--- @param handle number -- Entity handle
--- @return boolean exists -- Returns true if the entity pointed to by handle still exists
--- ### Example
--- ```lua
--- function init()
--- 	local body = FindBody("body", true)
--- 	--valid is true if body still exists
--- 	DebugPrint(IsHandleValid(body))
--- 	Delete(body)
--- 	--valid will now be false
--- 	DebugPrint(IsHandleValid(body))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#IsHandleValid)
function IsHandleValid(handle) end

--- Returns the type name of provided entity, for example "body", "shape", "light", etc.
--- @param handle number -- Entity handle
--- @return string type -- Type name of the provided entity
--- ### Example
--- ```lua
--- function init()
--- 	local body = FindBody("body", true)
--- 	DebugPrint(GetEntityType(body))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEntityType)
function GetEntityType(handle) end

--- @param handle number -- Entity handle
--- @param property string -- Property name
--- @return any value -- Property value
--- ### Example
--- ```lua
--- function client.tick()
--- 	local body = FindBody("testbody", true)
--- 	local isDynamic = GetProperty(body, "dynamic")
--- 	DebugWatch("isDynamic", isDynamic)
--- end
--- ```
--- @see GetProperty_EntityType
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetProperty)
function GetProperty(handle, property) end

--- ### SERVER ONLY
--- @param handle number -- Entity handle
--- @param property string -- Property name
--- @param value any -- Property value
--- ### Example
--- ```lua
--- function tick()
--- 	local light = FindLight("mylight", true)
--- 	SetProperty(light, "intensity", math.abs(math.sin(GetTime())))
--- end
--- ```
--- @see SetProperty_EntityType
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetProperty)
function SetProperty(handle, property, value) end

