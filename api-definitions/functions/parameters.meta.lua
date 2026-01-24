--- @meta


--- @param name string -- Parameter name
--- @param default number -- Default parameter value
--- @return number value -- Parameter value
--- ### Example
--- ```lua
--- function init()
--- 	--Retrieve blinkcount parameter, or set to 5 if omitted
--- 	local parameterBlinkCount = GetIntParam("blinkcount", 5)
--- 	DebugPrint(parameterBlinkCount)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetIntParam)
function GetIntParam(name, default) end

--- @param name string -- Parameter name
--- @param default number -- Default parameter value
--- @return number value -- Parameter value
--- ### Example
--- ```lua
--- function init()
--- 	--Retrieve speed parameter, or set to 10.0 if omitted
--- 	local parameterSpeed = GetFloatParam("speed", 10.0)
--- 	DebugPrint(parameterSpeed)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetFloatParam)
function GetFloatParam(name, default) end

--- @param name string -- Parameter name
--- @param default boolean -- Default parameter value
--- @return boolean value -- Parameter value
--- ### Example
--- ```lua
--- function init()
--- 	--Retrieve playsound parameter, or false if omitted
--- 	local parameterPlaySound = GetBoolParam("playsound", false)
--- 	DebugPrint(parameterPlaySound)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetBoolParam)
function GetBoolParam(name, default) end

--- @param name string -- Parameter name
--- @param default string -- Default parameter value
--- @return string value -- Parameter value
--- ### Example
--- ```lua
--- function init()
--- 	--Retrieve mode parameter, or "idle" if omitted
--- 	local parameterMode = GetStringParam("mode", "idle")
--- 	DebugPrint(parameterMode)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetStringParam)
function GetStringParam(name, default) end

--- @param name string -- Parameter name
--- @param default number -- Default parameter value
--- @return number value -- Parameter value
--- ### Example
--- ```lua
--- function init()
--- 	--Retrieve color parameter, or set to 0.39, 0.39, 0.39 if omitted
--- 	local color_r, color_g, color_b = GetColorParam("color", 0.39, 0.39, 0.39)
--- 	DebugPrint(color_r .. " " .. color_g .. " " .. color_b)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetColorParam)
function GetColorParam(name, default) end

