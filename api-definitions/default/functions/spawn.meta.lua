--- @meta


--- The first argument can be either a prefab XML file in your mod folder or a string with XML content. It is also
--- possible to spawn prefabs from other mods, by using the mod id followed by colon, followed by the prefab path.
--- Spawning prefabs from other mods should be used with causion since the referenced mod might not be installed.


--- ### Example
--- ```lua
--- function server.init()
--- 	Spawn("MOD/prefab/mycar.xml", Transform(Vec(0, 5, 0)))
--- 	Spawn("&lt;voxbox size='10 10 10' prop='true' material='wood'/&gt;", Transform(Vec(0, 10, 0)))
--- end
--- ```
--- @param xml string -- File name or xml string
--- @param transform TTransform -- Spawn transform
--- @param allowStatic? boolean -- Allow spawning static shapes and bodies (default false)
--- @param jointExisting? boolean -- Allow joints to connect to existing scene geometry (default false)
--- @return table entities -- Indexed table with handles to all spawned entities
--- [View Documentation](https://teardowngame.com/experimental/api.html#Spawn)
function Spawn(xml, transform, allowStatic, jointExisting) end

--- Same functionality as Spawn(), except using a specific layer in the vox-file
--- ### Example
--- ```lua
--- function server.init()
--- 	Spawn("MOD/prefab/mycar.xml", "some_vox_layer", Transform(Vec(0, 5, 0)))
--- 	Spawn("&lt;voxbox size='10 10 10' prop='true' material='wood'/&gt;", "some_vox_layer", Transform(Vec(0, 10, 0)))
--- end
--- ```
--- @param xml string -- File name or xml string
--- @param layer string -- Vox layer name
--- @param transform TTransform -- Spawn transform
--- @param allowStatic? boolean -- Allow spawning static shapes and bodies (default false)
--- @param jointExisting? boolean -- Allow joints to connect to existing scene geometry (default false)
--- @return table entities -- Indexed table with handles to all spawned entities
--- [View Documentation](https://teardowngame.com/experimental/api.html#SpawnLayer)
function SpawnLayer(xml, layer, transform, allowStatic, jointExisting) end

--- ### Example
--- ```lua
--- function server.init()
--- 	SpawnTool("sledge", Transform(Vec(0, 5, 0)))
--- end
--- ```
--- @param id string -- Tool ID
--- @param transform TTransform -- Spawn transform
--- @param allowStatic? boolean -- Allow spawning static shapes and bodies (default false)
--- @param voxScale? number -- Applies a scale to voxels (default 1.0)
--- @return table entities -- Indexed table with handles to all spawned entities
--- [View Documentation](https://teardowngame.com/experimental/api.html#SpawnTool)
function SpawnTool(id, transform, allowStatic, voxScale) end

