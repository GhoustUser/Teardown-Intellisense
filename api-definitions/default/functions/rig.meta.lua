--- @meta


--- ### Example
--- ```lua
--- function client.init()
--- 	local rig = FindRig("myrig")
--- end
--- ```
--- @param tag? string -- Tag name
--- @param global? boolean -- Search in entire scene
--- @return number handle -- Handle to first rig with specified tag or zero if not found
--- [View Documentation](https://teardowngame.com/experimental/api.html#FindRig)
function FindRig(tag, global) end

--- ### Example
--- ```lua
--- local t = GetRigWorldTransform(rig)
--- ```
--- @param rig number -- Rig handle
--- @return TTransform transform -- World transform, nil if rig is missing
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRigWorldTransform)
function GetRigWorldTransform(rig) end

--- ### Example
--- ```lua
--- SetRigWorldTransform(rig, Transform(...))
--- ```
--- @param rig number -- Rig handle
--- @param transform TTransform -- New world transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRigWorldTransform)
function SetRigWorldTransform(rig, transform) end

--- ### Example
--- ```lua
--- local foot_t = GetRigLocationWorldTransform(rigid, "ik_foot_l")
--- ```
--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @return TTransform transform -- World transform, nil if rig is missing or location is missing
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRigLocationWorldTransform)
function GetRigLocationWorldTransform(rig, name) end

--- ### Example
--- ```lua
--- SetRigLocationWorldTransform(rig, "some_location_name", Transform(...))
--- ```
--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @param transform TTransform -- New world transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRigLocationWorldTransform)
function SetRigLocationWorldTransform(rig, name, transform) end

--- ### Example
--- ```lua
--- local t = GetRigLocationLocalTransform(rigid, "some_location_name")
--- ```
--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @return TTransform transform -- Local transform, nil if rig is missing or location is missing
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetRigLocationLocalTransform)
function GetRigLocationLocalTransform(rig, name) end

--- ### Example
--- ```lua
--- local someBody = FindBody("bodyname")
--- SetPlayerRigTransform(someBody, GetBodyTransform(someBody))
--- ```
--- @param rig number -- Rig handle
--- @param name string -- Name of location
--- @param transform TTransform -- New world transform
--- [View Documentation](https://teardowngame.com/experimental/api.html#SetRigLocationLocalTransform)
function SetRigLocationLocalTransform(rig, name, transform) end

