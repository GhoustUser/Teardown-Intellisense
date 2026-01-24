--- @meta


--- @param path string -- Path to sprite. Must be PNG or JPG format.
--- @return number handle -- Sprite handle
--- ### Example
--- ```lua
--- function client.init()
--- 	arrow = LoadSprite("gfx/arrowdown.png")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#LoadSprite)
function LoadSprite(path) end

--- Draw sprite in world at next frame. Call this function from the tick callback.
--- @param handle number -- Sprite handle
--- @param transform TTransform -- Transform
--- @param width number -- Width in meters
--- @param height number -- Height in meters
--- @param r? number -- Red color. Default 1.0.
--- @param g? number -- Green color. Default 1.0.
--- @param b? number -- Blue color. Default 1.0.
--- @param a? number -- Alpha. Default 1.0.
--- @param depthTest? boolean -- Depth test enabled. Default false.
--- @param additive? boolean -- Additive blending enabled. Default false.
--- @param fogAffected? boolean -- Enable distance fog effect. Default false.
--- ### Example
--- ```lua
--- function client.init()
--- 	arrow = LoadSprite("gfx/arrowdown.png")
--- end
--- function client.tick()
--- 	--Draw sprite using transform
--- 	--Size is two meters in width and height
--- 	--Color is white, fully opaue
--- 	local t = Transform(Vec(0, 10, 0), QuatEuler(0, GetTime(), 0))
--- 	DrawSprite(arrow, t, 2, 2, 1, 1, 1, 1)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#DrawSprite)
function DrawSprite(handle, transform, width, height, r, g, b, a, depthTest, additive, fogAffected) end

