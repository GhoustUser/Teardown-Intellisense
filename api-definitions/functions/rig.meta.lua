--- @meta


--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first rig with specified tag or zero if not found
--- ### Example
--- ```lua
--- function client.init()
--- 	local rig = FindRig("myrig")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindRig)
function FindRig(tag, global) end

--- @param rig number -- Rig handle
--- @return TTransform transform -- World transform, nil if rig is missing
--- ### Example
--- ```lua
--- 	local t = GetRigWorldTransform(rig)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRigWorldTransform)
function GetRigWorldTransform(rig) end

--- @param rig number -- Rig handle
--- @param transform TTransform -- New world transform
--- ### Example
--- ```lua
--- 	SetRigWorldTransform(rig, Transform(...))
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRigWorldTransform)
function SetRigWorldTransform(rig, transform) end

--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @return TTransform transform -- World transform, nil if rig is missing or location is missing
--- ### Example
--- ```lua
--- local foot_t = GetRigLocationWorldTransform(rigid, "ik_foot_l")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRigLocationWorldTransform)
function GetRigLocationWorldTransform(rig, name) end

--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @param transform TTransform -- New world transform
--- ### Example
--- ```lua
--- 	SetRigLocationWorldTransform(rig, "some_location_name", Transform(...))
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRigLocationWorldTransform)
function SetRigLocationWorldTransform(rig, name, transform) end

--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @return TTransform transform -- Local transform, nil if rig is missing or location is missing
--- ### Example
--- ```lua
--- local t = GetRigLocationLocalTransform(rigid, "some_location_name")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRigLocationLocalTransform)
function GetRigLocationLocalTransform(rig, name) end

--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @param transform TTransform -- New world transform
--- ### Example
--- ```lua
--- 	local someBody = FindBody("bodyname")
--- 	SetPlayerRigTransform(someBody, GetBodyTransform(someBody))
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRigLocationLocalTransform)
function SetRigLocationLocalTransform(rig, name, transform) end

