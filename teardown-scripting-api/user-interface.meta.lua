--- @meta

--- @alias UiAlign_Alignment
--- | 'left' Horizontally align to the left
--- | 'right' Horizontally align to the right
--- | 'center' Horizontally align to the center
--- | 'top' Vertically align to the top
--- | 'bottom' Veritcally align to the bottom
--- | 'middle' Vertically align to the middle

--- @alias UiTextAlignment_Alignment
--- | 'left' Horizontally align to the left
--- | 'right' Horizontally align to the right
--- | 'center' Horizontally align to the center

--- Calling this function will disable game input, bring up the mouse pointer
--- and allow Ui interaction with the calling script without pausing the game.
--- This can be useful to make interactive user interfaces from scripts while
--- the game is running. Call this continuously every frame as long as Ui
--- interaction is desired.
--- ### Example
--- ```lua
--- UiMakeInteractive()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiMakeInteractive)
function UiMakeInteractive() end

--- Push state onto stack. This is used in combination with UiPop to
--- remember a state and restore to that state later.
--- ### Example
--- ```lua
--- UiColor(1,0,0)
--- UiText("Red")
--- UiPush()
--- 	UiColor(0,1,0)
--- 	UiText("Green")
--- UiPop()
--- UiText("Red")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiPush)
function UiPush() end

--- Pop state from stack and make it the current one. This is used in
--- combination with UiPush to remember a previous state and go back to
--- it later.
--- ### Example
--- ```lua
--- UiColor(1,0,0)
--- UiText("Red")
--- UiPush()
--- 	UiColor(0,1,0)
--- 	UiText("Green")
--- UiPop()
--- UiText("Red")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiPop)
function UiPop() end

--- @return number width -- Width of draw context
--- ### Example
--- ```lua
--- local w = UiWidth()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiWidth)
function UiWidth() end

--- @return number height -- Height of draw context
--- ### Example
--- ```lua
--- local h = UiHeight()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiHeight)
function UiHeight() end

--- @return number center -- Half width of draw context
--- ### Example
--- ```lua
--- local c = UiCenter()
--- --Same as
--- local c = UiWidth()/2
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiCenter)
function UiCenter() end

--- @return number middle -- Half height of draw context
--- ### Example
--- ```lua
--- local m = UiMiddle()
--- --Same as
--- local m = UiHeight()/2
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiMiddle)
function UiMiddle() end

--- @param r number -- Red channel
--- @param g number -- Green channel
--- @param b number -- Blue channel
--- @param a? number -- Alpha channel. Default 1.0
--- ### Example
--- ```lua
--- --Set color yellow
--- UiColor(1,1,0)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiColor)
function UiColor(r, g, b, a) end

--- Color filter, multiplied to all future colors in this scope
--- @param r number -- Red channel
--- @param g number -- Green channel
--- @param b number -- Blue channel
--- @param a? number -- Alpha channel. Default 1.0
--- ### Example
--- ```lua
--- UiPush()
--- 	--Draw menu in transparent, yellow color tint
--- 	UiColorFilter(1, 1, 0, 0.5)
--- 	drawMenu()
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiColorFilter)
function UiColorFilter(r, g, b, a) end

--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiFont("bold.ttf", 44)
--- 		UiTranslate(100, 100)
--- 		UiColor(1, 0, 0)
--- 		UiText("A")
--- 		UiTranslate(100, 0)
--- 		UiResetColor()
--- 		UiText("B")
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiResetColor)
function UiResetColor() end

--- Translate cursor
--- @param x number -- X component
--- @param y number -- Y component
--- ### Example
--- ```lua
--- UiPush()
--- 	UiTranslate(100, 0)
--- 	UiText("Indented")
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTranslate)
function UiTranslate(x, y) end

--- Rotate cursor
--- @param angle number -- Angle in degrees, counter clockwise
--- ### Example
--- ```lua
--- UiPush()
--- 	UiRotate(45)
--- 	UiText("Rotated")
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiRotate)
function UiRotate(angle) end

--- Scale cursor either uniformly (one argument) or non-uniformly (two arguments)
--- @param x number -- X component
--- @param y? number -- Y component. Default value is x.
--- ### Example
--- ```lua
--- UiPush()
--- 	UiScale(2)
--- 	UiText("Double size")
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiScale)
function UiScale(x, y) end

--- Returns the ui context's scale
--- @return number x -- X scale
--- @return number y -- Y scale
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiScale(2)
--- 		x, y = UiGetScale()
--- 		DebugPrint(x .. " " .. y)
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetScale)
function UiGetScale() end

--- @param width number -- Rect width
--- @param height number -- Rect height
--- @param inherit? boolean -- True if must include the parent's clip rect
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiTranslate(200, 200)
--- 	UiPush()
--- 		UiClipRect(100, 50)
--- 		UiTranslate(5, 15)
--- 		UiFont("regular.ttf", 50)
--- 		UiText("Text")
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiClipRect)
function UiClipRect(width, height, inherit) end

--- Set up new bounds. Calls to UiWidth, UiHeight, UiCenter and UiMiddle
--- will operate in the context of the window size.
--- If clip is set to true, contents of window will be clipped to
--- bounds (only works properly for non-rotated windows).
--- @param width number -- Window width
--- @param height number -- Window height
--- @param clip? boolean -- Clip content outside window. Default is false.
--- @param inherit? boolean -- Inherit current clip region (for nested clip regions)
--- ### Example
--- ```lua
--- UiPush()
--- 	UiWindow(400, 200)
--- 	local w = UiWidth()
--- 	--w is now 400
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiWindow)
function UiWindow(width, height, clip, inherit) end

--- Returns the top left & bottom right points of the current window
--- @return number tl_x -- Top left x
--- @return number tl_y -- Top left y
--- @return number br_x -- Bottom right x
--- @return number br_y -- Bottom right y
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiWindow(400, 200)
--- 		tl_x, tl_y, br_x, br_y = UiGetCurrentWindow()
--- 		-- do something
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetCurrentWindow)
function UiGetCurrentWindow() end

--- True if the specified point is within the boundaries of the current window
--- @param x number -- X
--- @param y number -- Y
--- @return boolean val -- True if
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiWindow(400, 200)
--- 		DebugPrint("point 1: " .. tostring(UiIsInCurrentWindow(200, 100)))
--- 		DebugPrint("point 2: " .. tostring(UiIsInCurrentWindow(450, 100)))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIsInCurrentWindow)
function UiIsInCurrentWindow(x, y) end

--- Checks whether a rectangle with width w and height h is completely clipped
--- @param w number -- Width
--- @param h number -- Height
--- @return boolean value -- True if rect is fully clipped
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiTranslate(200, 200)
--- 	UiPush()
--- 		UiClipRect(150, 150)
--- 		UiColor(1.0, 1.0, 1.0, 0.15)
--- 		UiRect(150, 150)
--- 		UiRect(w, h)
--- 		UiTranslate(-50, 30)
--- 		UiColor(1, 0, 0)
--- 		local w, h = 100, 100
--- 		UiRect(w, h)
--- 		DebugPrint(UiIsRectFullyClipped(w, h))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIsRectFullyClipped)
function UiIsRectFullyClipped(w, h) end

--- Checks whether a point is inside the clip region
--- @param x number -- X
--- @param y number -- Y
--- @return boolean value -- True if point is in clip region
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiTranslate(200, 200)
--- 		UiClipRect(150, 150)
--- 		UiColor(1.0, 1.0, 1.0, 0.15)
--- 		UiRect(150, 150)
--- 		UiRect(w, h)
--- 		DebugPrint("point 1: " .. tostring(UiIsInClipRegion(250, 250)))
--- 		DebugPrint("point 2: " .. tostring(UiIsInClipRegion(350, 250)))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIsInClipRegion)
function UiIsInClipRegion(x, y) end

--- Checks whether a rect is overlap the clip region
--- @param w number -- Width
--- @param h number -- Height
--- @return boolean value -- True if rect is not overlapping clip region
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiTranslate(200, 200)
--- 		UiClipRect(150, 150)
--- 		UiColor(1.0, 1.0, 1.0, 0.15)
--- 		UiRect(150, 150)
--- 		UiRect(w, h)
--- 		DebugPrint("rect 1: " .. tostring(UiIsFullyClipped(200, 200)))
--- 		UiTranslate(200, 0)
--- 		DebugPrint("rect 2: " .. tostring(UiIsFullyClipped(200, 200)))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIsFullyClipped)
function UiIsFullyClipped(w, h) end

--- Return a safe drawing area that will always be visible regardless of
--- display aspect ratio. The safe drawing area will always be 1920 by 1080
--- in size. This is useful for setting up a fixed size UI.
--- @return number x0 -- Left
--- @return number y0 -- Top
--- @return number x1 -- Right
--- @return number y1 -- Bottom
--- ### Example
--- ```lua
--- function client.draw()
--- 	local x0, y0, x1, y1 = UiSafeMargins()
--- 	UiTranslate(x0, y0)
--- 	UiWindow(x1-x0, y1-y0, true)
--- 	--The drawing area is now 1920 by 1080 in the center of screen
--- 	drawMenu()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSafeMargins)
function UiSafeMargins() end

--- Returns the canvas size. "Canvas" means a coordinate space in which UI is drawn
--- @return table value -- Canvas width and height
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		local canvas = UiCanvasSize()
--- 		UiWindow(canvas.w, canvas.h)
--- 		--[[
--- 			...
--- 		]]
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiCanvasSize)
function UiCanvasSize() end

--- @param alignment UiAlign_Alignment -- Alignment keywords
--- ### Example
--- ```lua
--- UiAlign("left")
--- UiText("Aligned left at baseline")
--- UiAlign("center middle")
--- UiText("Fully centered")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiAlign)
function UiAlign(alignment) end

--- @param alignment UiTextAlignment_Alignment -- Alignment keyword
--- ### Example
--- ```lua
--- UiTextAlignment("left")
--- UiText("Aligned left at baseline")
--- UiTextAlignment("center")
--- UiText("Centered")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextAlignment)
function UiTextAlignment(alignment) end

--- Disable input for everything, except what's between UiModalBegin and UiModalEnd
--- (or if modal state is popped)
--- @param force? boolean -- Pass true if you need to increase the priority of this modal in the context
--- ### Example
--- ```lua
--- UiModalBegin()
--- if UiTextButton("Okay") then
--- 	--All other interactive ui elements except this one are disabled
--- end
--- UiModalEnd()
--- --This is also okay
--- UiPush()
--- 	UiModalBegin()
--- 	if UiTextButton("Okay") then
--- 		--All other interactive ui elements except this one are disabled
--- 	end
--- UiPop()
--- --No longer modal
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiModalBegin)
function UiModalBegin(force) end

--- Disable input for everything, except what's between UiModalBegin and UiModalEnd
--- Calling this function is optional. Modality is part of the current state and will
--- be lost if modal state is popped.
--- ### Example
--- ```lua
--- UiModalBegin()
--- if UiTextButton("Okay") then
--- 	--All other interactive ui elements except this one are disabled
--- end
--- UiModalEnd()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiModalEnd)
function UiModalEnd() end

--- Disable input
--- ### Example
--- ```lua
--- UiPush()
--- 	UiDisableInput()
--- 	if UiTextButton("Okay") then
--- 		--Will never happen
--- 	end
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiDisableInput)
function UiDisableInput() end

--- Enable input that has been previously disabled
--- ### Example
--- ```lua
--- UiDisableInput()
--- if UiTextButton("Okay") then
--- 	--Will never happen
--- end
--- UiEnableInput()
--- if UiTextButton("Okay") then
--- 	--This can happen
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiEnableInput)
function UiEnableInput() end

--- This function will check current state receives input. This is the case
--- if input is not explicitly disabled with (with UiDisableInput) and no other
--- state is currently modal (with UiModalBegin). Input functions and UI
--- elements already do this check internally, but it can sometimes be useful
--- to read the input state manually to trigger things in the UI.
--- @return boolean receives -- True if current context receives input
--- ### Example
--- ```lua
--- if UiReceivesInput() then
--- 	highlightItemAtMousePointer()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiReceivesInput)
function UiReceivesInput() end

--- Get mouse pointer position relative to the cursor
--- @return number x -- X coordinate
--- @return number y -- Y coordinate
--- ### Example
--- ```lua
--- local x, y = UiGetMousePos()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetMousePos)
function UiGetMousePos() end

--- @return number x -- X coordinate
--- @return number y -- Y coordinate
--- ### Example
--- ```lua
--- function client.draw()
--- 	local x, y = UiGetCanvasMousePos()
--- 	DebugPrint("x :" .. x .. " y:" .. y)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetCanvasMousePos)
function UiGetCanvasMousePos() end

--- Check if mouse pointer is within rectangle. Note that this function respects
--- alignment.
--- @param w number -- Width
--- @param h number -- Height
--- @return boolean inside -- True if mouse pointer is within rectangle
--- ### Example
--- ```lua
--- if UiIsMouseInRect(100, 100) then
--- 	-- mouse pointer is in rectangle
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIsMouseInRect)
function UiIsMouseInRect(w, h) end

--- Convert world space position to user interface X and Y coordinate relative
--- to the cursor. The distance is in meters and positive if in front of camera,
--- negative otherwise.
--- @param point TVec -- 3D world position as vector
--- @return number x -- X coordinate
--- @return number y -- Y coordinate
--- @return number distance -- Distance to point
--- ### Example
--- ```lua
--- local x, y, dist = UiWorldToPixel(point)
--- if dist > 0 then
--- UiTranslate(x, y)
--- UiText("Label")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiWorldToPixel)
function UiWorldToPixel(point) end

--- Convert X and Y UI coordinate to a world direction, as seen from current camera.
--- This can be used to raycast into the scene from the mouse pointer position.
--- @param x number -- X coordinate
--- @param y number -- Y coordinate
--- @return TVec direction -- 3D world direction as vector
--- ### Example
--- ```lua
--- UiMakeInteractive()
--- local x, y = UiGetMousePos()
--- local dir = UiPixelToWorld(x, y)
--- local pos = GetCameraTransform().pos
--- local hit, dist = QueryRaycast(pos, dir, 100)
--- if hit then
--- 	DebugPrint("hit distance: " .. dist)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiPixelToWorld)
function UiPixelToWorld(x, y) end

--- Returns the ui cursor's postion
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiTranslate(100, 50)
--- 	x, y = UiGetCursorPos()
--- 	DebugPrint("x: " .. x .. "; y: " .. y)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetCursorPos)
function UiGetCursorPos() end

--- Perform a gaussian blur on current screen content
--- @param amount number -- Blur amount (0.0 to 1.0)
--- ### Example
--- ```lua
--- UiBlur(1.0)
--- drawMenu()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiBlur)
function UiBlur(amount) end

--- @param path string -- Path to TTF font file
--- @param size number -- Font size (10 to 100)
--- ### Example
--- ```lua
--- UiFont("bold.ttf", 24)
--- UiText("Hello")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFont)
function UiFont(path, size) end

--- @return number size -- Font size
--- ### Example
--- ```lua
--- local h = UiFontHeight()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFontHeight)
function UiFontHeight() end

--- @param text string -- Print text at cursor location
--- @param move? boolean -- Automatically move cursor vertically. Default false.
--- @param maxChars? number -- Maximum amount of characters. Default 100000.
--- @return number w -- Width of text
--- @return number h -- Height of text
--- @return number x -- End x-position of text.
--- @return number y -- End y-position of text.
--- @return string linkId -- Link id of clicked link
--- ### Example
--- ```lua
--- UiFont("bold.ttf", 24)
--- UiText("Hello")
--- ...
--- --Automatically advance cursor
--- UiText("First line", true)
--- UiText("Second line", true)
--- --Using links
--- UiFont("bold.ttf", 26)
--- UiTranslate(100,100)
--- --Using virtual links
--- link = "[[link;label=loc@UI_TEXT_FREE_ROAM_OPTIONS_LINK_NAME;id=options/game;color=#DDDD7FDD;underline=true]]"
--- someText = "Some text with a link: " .. link .. " and some more text"
--- w, h, x, y, linkId = UiText(someText)
--- if linkId:len() ~= 0 then
--- 	if linkId == "options/game" then
--- 		DebugPrint(linkId.." link clicked")
--- 	elseif linkId == "options/sound" then
--- 		--Do something else
--- 	end
--- end
--- UiTranslate(0,50)
--- --Using game links, id attribute is required, color is optional, same as virtual links
--- link = "[[game://options;label=loc@UI_TEXT_FREE_ROAM_OPTIONS_LINK_NAME;id=game;color=#DDDD7FDD;underline=false]]"
--- someText = "Some text with a link: " .. link .. " and some more text"
--- w, h, x, y, linkId = UiText(someText)
--- if linkId:len() ~= 0 then
--- 	DebugPrint(linkId.." link clicked")
--- end
--- UiTranslate(0,50)
--- --Using http/s links is also possible, link will be opened in the default browser
--- link = "[[http://www.example.com;label=loc@SOME_KEY;]]"
--- someText = "Goto: " .. link
--- UiText(someText)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiText)
function UiText(text, move, maxChars) end

--- @param disable boolean -- Enable or disable wildcard [[...]] substitution support in UiText
--- ### Example
--- ```lua
--- UiFont("regular.ttf", 30)
--- UiPush()
--- 	UiTextDisableWildcards(true)
--- 	-- icon won't be embedded here, text will be left as is
--- 	UiText("Text with embedded icon image [[menu:menu_accept;iconsize=42,42]]")
--- UiPop()
--- -- embedding works as expected
--- UiText("Text with embedded icon image [[menu:menu_accept;iconsize=42,42]]")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextDisableWildcards)
function UiTextDisableWildcards(disable) end

--- This function toggles the use of a fixed line height for text rendering.
--- When enabled (true), the line height is set to a constant value determined by
--- the current font metrics, ensuring uniform spacing between lines of text.
--- This mode is useful for maintaining consistent line spacing across different
--- text elements, regardless of the specific characters displayed.
--- When disabled (false), the line height adjusts dynamically to accommodate
--- the tallest character in each line of text.
--- @param uniform boolean -- Enable or disable fixed line height for text rendering
--- ### Example
--- ```lua
--- #include "script/common.lua"
--- enabled = false
--- group = 1
--- local desc = {
--- 	{
--- 		{"A mod desc without descenders"},
--- 		{"Author: Abcd"},
--- 		{"Tags: map, spawnable"},
--- 	},
--- 	{
--- 		{"A mod with descenders, like g, j, p, q, y"},
--- 		{"Author: Ggjyq"},
--- 		{"Tags: map, spawnable"},
--- 	},
--- }
--- -- Function to draw text with or without uniform line height
--- local function drawDescriptions()
--- 	UiAlign("top")
--- 	for _, text in ipairs(desc[group]) do
--- 		UiTextUniformHeight(enabled)
--- 		UiText(text[1], true)
--- 	end
--- end
--- function client.draw()
--- 	UiFont("regular.ttf", 22)
--- 	UiTranslate(100, 100)
--- 	UiPush()
--- 		local r,g,b
--- 		if enabled then
--- 			r,g,b = 0,1,0
--- 		else
--- 			r,g,b = 1,0,0
--- 		end
--- 		UiColor(0,0,0)
--- 		UiButtonImageBox("ui/common/box-solid-6.png", 6, 6, r,g,b)
--- 		if UiTextButton("Uniform height "..(enabled and "enabled" or "disabled")) then
--- 			enabled = not enabled
--- 		end
--- 		UiTranslate(0,35)
--- 		if UiTextButton(">") then
--- 			group = clamp(group + 1, 1, #desc)
--- 		end
--- 		UiTranslate(0,35)
--- 		if UiTextButton("<") then
--- 			group = clamp(group - 1, 1, #desc)
--- 		end
--- 	UiPop()
--- 	UiTranslate(0,80)
--- 	drawDescriptions()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextUniformHeight)
function UiTextUniformHeight(uniform) end

--- @param text string -- A text string
--- @return number w -- Width of text
--- @return number h -- Height of text
--- @return number x -- Offset x-component of text AABB
--- @return number y -- Offset y-component of text AABB
--- ### Example
--- ```lua
--- local w, h = UiGetTextSize("Some text")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetTextSize)
function UiGetTextSize(text) end

--- @param space number -- Space between lines
--- @param textOrLocale string -- , ... A text strings
--- @return number w -- Width of biggest line
--- @return number h -- Height of all lines combined with interval
--- ### Example
--- ```lua
--- local w, h = UiMeasureText(0, "Some text", "loc@key")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiMeasureText)
function UiMeasureText(space, textOrLocale) end

--- @param text string -- Text
--- @return number count -- Symbols count
--- ### Example
--- ```lua
--- function client.draw()
--- 	DebugPrint(UiGetSymbolsCount("Hello world!"))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetSymbolsCount)
function UiGetSymbolsCount(text) end

--- Returns the substring. This function is intended to properly work with UTF8 encoded strings
--- @param text string -- Text
--- @param from number -- From element index
--- @param to number -- To element index
--- @return string substring -- Substring
--- ### Example
--- ```lua
--- function client.draw()
--- 	DebugPrint(UiTextSymbolsSub("Hello world", 1, 5))
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextSymbolsSub)
function UiTextSymbolsSub(text, from, to) end

--- @param width number -- Maximum width of text
--- ### Example
--- ```lua
--- UiWordWrap(200)
--- UiText("Some really long text that will get wrapped into several lines")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiWordWrap)
function UiWordWrap(width) end

--- Sets the context's linespacing value of the text which is drawn using UiText
--- @param value number -- Text linespacing
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiTextLineSpacing(10)
--- 	UiWordWrap(200)
--- 	UiText("TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextLineSpacing)
function UiTextLineSpacing(value) end

--- @param r number -- Red channel
--- @param g number -- Green channel
--- @param b number -- Blue channel
--- @param a number -- Alpha channel
--- @param thickness? number -- Outline thickness. Default is 0.1
--- ### Example
--- ```lua
--- --Black outline, standard thickness
--- UiTextOutline(0,0,0,1)
--- UiText("Text with outline")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextOutline)
function UiTextOutline(r, g, b, a, thickness) end

--- @param r number -- Red channel
--- @param g number -- Green channel
--- @param b number -- Blue channel
--- @param a number -- Alpha channel
--- @param distance? number -- Shadow distance. Default is 1.0
--- @param blur? number -- Shadow blur. Default is 0.5
--- ### Example
--- ```lua
--- --Black drop shadow, 50% transparent, distance 2
--- UiTextShadow(0, 0, 0, 0.5, 2.0)
--- UiText("Text with drop shadow")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextShadow)
function UiTextShadow(r, g, b, a, distance, blur) end

--- Draw solid rectangle at cursor position
--- @param w number -- Width
--- @param h number -- Height
--- ### Example
--- ```lua
--- --Draw full-screen black rectangle
--- UiColor(0, 0, 0)
--- UiRect(UiWidth(), UiHeight())
--- --Draw smaller, red, rotating rectangle in center of screen
--- UiPush()
--- 	UiColor(1, 0, 0)
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiRotate(GetTime())
--- 	UiAlign("center middle")
--- 	UiRect(100, 100)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiRect)
function UiRect(w, h) end

--- Draw rectangle outline at cursor position
--- @param width number -- Rectangle width
--- @param height number -- Rectangle height
--- @param thickness number -- Rectangle outline thickness
--- ### Example
--- ```lua
--- --Draw a red rotating rectangle outline in center of screen
--- UiPush()
--- 	UiColor(1, 0, 0)
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiRotate(GetTime())
--- 	UiAlign("center middle")
--- 	UiRectOutline(100, 100, 5)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiRectOutline)
function UiRectOutline(width, height, thickness) end

--- Draw a solid rectangle with round corners of specified radius
--- @param width number -- Rectangle width
--- @param height number -- Rectangle height
--- @param roundingRadius number -- Round corners radius
--- ### Example
--- ```lua
--- UiPush()
--- 	UiColor(1, 0, 0)
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiRotate(GetTime())
--- 	UiAlign("center middle")
--- 	UiRoundedRect(100, 100, 8)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiRoundedRect)
function UiRoundedRect(width, height, roundingRadius) end

--- Draw rectangle outline with round corners at cursor position
--- @param width number -- Rectangle width
--- @param height number -- Rectangle height
--- @param roundingRadius number -- Round corners radius
--- @param thickness number -- Rectangle outline thickness
--- ### Example
--- ```lua
--- UiPush()
--- 	UiColor(1, 0, 0)
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiRotate(GetTime())
--- 	UiAlign("center middle")
--- 	UiRoundedRectOutline(100, 100, 20, 5)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiRoundedRectOutline)
function UiRoundedRectOutline(width, height, roundingRadius, thickness) end

--- Draw a solid circle at cursor position
--- @param radius number -- Circle radius
--- ### Example
--- ```lua
--- UiPush()
--- 	UiColor(1, 0, 0)
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiAlign("center middle")
--- 	UiCircle(100)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiCircle)
function UiCircle(radius) end

--- Draw a circle outline at cursor position
--- @param radius number -- Circle radius
--- @param thickness number -- Circle outline thickness
--- ### Example
--- ```lua
--- --Draw a red rotating rectangle outline in center of screen
--- UiPush()
--- 	UiColor(1, 0, 0)
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiAlign("center middle")
--- 	UiCircleOutline(100, 8)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiCircleOutline)
function UiCircleOutline(radius, thickness) end

--- Image to fill for UiRoundedRect, UiCircle
--- @param path string -- Path to image (PNG or JPG format)
--- ### Example
--- ```lua
--- UiPush()
--- 	UiFillImage("ui/hud/tutorial/plank-lift.jpg")
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiRotate(GetTime())
--- 	UiAlign("center middle")
--- 	UiRoundedRect(100, 100, 8)
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFillImage)
function UiFillImage(path) end

--- Perform a gaussian blur on the background and applies the blur to any following calls to UiRect, 
--- UiRectOutline, UiRoundedRect, UiCircle, UiCircleOutline, UiRoundedRectOutline.
--- @param amount number -- Blur amount (0.0 to 1.0)
--- ### Example
--- ```lua
--- UiBackgroundBlur(1.0)
--- UiRect(300, 300)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiBackgroundBlur)
function UiBackgroundBlur(amount) end

--- Draw image at cursor position. If x0, y0, x1, y1 is provided a cropped version
--- will be drawn in that coordinate range.
--- @param path string -- Path to image (PNG or JPG format)
--- @param x0? number -- Lower x coordinate (default is 0)
--- @param y0? number -- Lower y coordinate (default is 0)
--- @param x1? number -- Upper x coordinate (default is image width)
--- @param y1? number -- Upper y coordinate (default is image height)
--- @return number w -- Width of drawn image
--- @return number h -- Height of drawn image
--- ### Example
--- ```lua
--- --Draw image in center of screen
--- UiPush()
--- 	UiTranslate(UiCenter(), UiMiddle())
--- 	UiAlign("center middle")
--- 	UiImage("test.png")
--- UiPop()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiImage)
function UiImage(path, x0, y0, x1, y1) end

--- Unloads a texture from the memory
--- @param path string -- Path to image (PNG or JPG format)
--- ### Example
--- ```lua
--- local image = "gfx/cursor.png"
--- function client.draw()
--- 	UiTranslate(300, 300)
--- 	if UiHasImage(image) then
--- 		if InputDown("interact") then
--- 			UiUnloadImage("img/background.jpg")
--- 		else
--- 			UiImage(image)
--- 		end
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiUnloadImage)
function UiUnloadImage(path) end

--- @param path string -- Path to image (PNG or JPG format)
--- @return boolean exists -- Does the image exists at the specified path
--- ### Example
--- ```lua
--- local image = "gfx/circle.png"
--- function client.draw()
--- 	if UiHasImage(image) then
--- 		DebugPrint("image " .. image .. " exists")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiHasImage)
function UiHasImage(path) end

--- Get image size
--- @param path string -- Path to image (PNG or JPG format)
--- @return number w -- Image width
--- @return number h -- Image height
--- ### Example
--- ```lua
--- local w,h = UiGetImageSize("test.png")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetImageSize)
function UiGetImageSize(path) end

--- Draw 9-slice image at cursor position. Width should be at least 2*borderWidth.
--- Height should be at least 2*borderHeight.
--- @param path string -- Path to image (PNG or JPG format)
--- @param width number -- Width
--- @param height number -- Height
--- @param borderWidth? number -- Border width. Default 0
--- @param borderHeight? number -- Border height. Default 0
--- ### Example
--- ```lua
--- UiImageBox("menu-frame.png", 200, 200, 10, 10)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiImageBox)
function UiImageBox(path, width, height, borderWidth, borderHeight) end

--- UI sounds are not affected by acoustics simulation. Use LoadSound / PlaySound for that.
--- @param path string -- Path to sound file (OGG format)
--- @param volume? number -- Playback volume. Default 1.0
--- @param pitch? number -- Playback pitch. Default 1.0
--- @param panAzimuth? number -- Playback stereo panning azimuth (-PI to PI). Default 0.0.
--- @param panDepth? number -- Playback stereo panning depth (0.0 to 1.0). Default 1.0.
--- ### Example
--- ```lua
--- UiSound("click.ogg")
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSound)
function UiSound(path, volume, pitch, panAzimuth, panDepth) end

--- Call this continuously to keep playing loop.
--- UI sounds are not affected by acoustics simulation. Use LoadLoop / PlayLoop for that.
--- @param path string -- Path to looping sound file (OGG format)
--- @param volume? number -- Playback volume. Default 1.0
--- @param pitch? number -- Playback pitch. Default 1.0
--- ### Example
--- ```lua
--- if animating then
--- 	UiSoundLoop("screech.ogg")
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSoundLoop)
function UiSoundLoop(path, volume, pitch) end

--- Mute game audio and optionally music for the next frame. Call
--- continuously to stay muted.
--- @param amount number -- Mute by this amount (0.0 to 1.0)
--- @param music? boolean -- Mute music as well
--- ### Example
--- ```lua
--- if menuOpen then
--- 	UiMute(1.0)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiMute)
function UiMute(amount, music) end

--- Set up 9-slice image to be used as background for buttons.
--- @param path string -- Path to image (PNG or JPG format)
--- @param borderWidth number -- Border width
--- @param borderHeight number -- Border height
--- @param r? number -- Red multiply. Default 1.0
--- @param g? number -- Green multiply. Default 1.0
--- @param b? number -- Blue multiply. Default 1.0
--- @param a? number -- Alpha channel. Default 1.0
--- ### Example
--- ```lua
--- UiButtonImageBox("button-9slice.png", 10, 10)
--- if UiTextButton("Test") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiButtonImageBox)
function UiButtonImageBox(path, borderWidth, borderHeight, r, g, b, a) end

--- Button color filter when hovering mouse pointer.
--- @param r number -- Red multiply
--- @param g number -- Green multiply
--- @param b number -- Blue multiply
--- @param a? number -- Alpha channel. Default 1.0
--- ### Example
--- ```lua
--- UiButtonHoverColor(1, 0, 0)
--- if UiTextButton("Test") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiButtonHoverColor)
function UiButtonHoverColor(r, g, b, a) end

--- Button color filter when pressing down.
--- @param r number -- Red multiply
--- @param g number -- Green multiply
--- @param b number -- Blue multiply
--- @param a? number -- Alpha channel. Default 1.0
--- ### Example
--- ```lua
--- UiButtonPressColor(0, 1, 0)
--- if UiTextButton("Test") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiButtonPressColor)
function UiButtonPressColor(r, g, b, a) end

--- The button offset when being pressed
--- @param distX number -- Press distance along X axis
--- @param distY number -- Press distance along Y axis
--- ### Example
--- ```lua
--- UiButtonPressDistance(4, 4)
--- if UiTextButton("Test") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiButtonPressDist)
function UiButtonPressDist(distX, distY) end

--- indicating how to handle text overflow.
--- Possible values are:
--- 0 - AsIs,
--- 1 - Slide,
--- 2 - Truncate,
--- 3 - Fade,
--- 4 - Resize (Default)
--- @param type number -- One of the enum value
--- ### Example
--- ```lua
--- UiButtonTextHandling(1)
--- if UiTextButton("Test") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiButtonTextHandling)
function UiButtonTextHandling(type) end

--- @param text string -- Text on button
--- @param w? number -- Button width
--- @param h? number -- Button height
--- @return boolean pressed -- True if user clicked button
--- ### Example
--- ```lua
--- if UiTextButton("Test") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiTextButton)
function UiTextButton(text, w, h) end

--- @param path string -- Image path (PNG or JPG file)
--- @return boolean pressed -- True if user clicked button
--- ### Example
--- ```lua
--- if UiImageButton("image.png") then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiImageButton)
function UiImageButton(path) end

--- @param w number -- Button width
--- @param h number -- Button height
--- @return boolean pressed -- True if user clicked button
--- ### Example
--- ```lua
--- if UiBlankButton(30, 30) then
--- 	...
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiBlankButton)
function UiBlankButton(w, h) end

--- @param path string -- Image path (PNG or JPG file)
--- @param axis string -- Drag axis, must be "x" or "y"
--- @param current number -- Current value
--- @param min number -- Minimum value
--- @param max number -- Maximum value
--- @return number value -- New value, same as current if not changed
--- @return boolean done -- True if user is finished changing (released slider)
--- ### Example
--- ```lua
--- value = UiSlider("dot.png", "x", value, 0, 100)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSlider)
function UiSlider(path, axis, current, min, max) end

--- Sets the slider hover color filter
--- @param r number -- Red channel
--- @param g number -- Green channel
--- @param b number -- Blue channel
--- @param a number -- Alpha channel
--- ### Example
--- ```lua
--- local slider = 0
--- function client.draw()
--- 	local thumbPath = "common/thumb_I218_249_2430_49029.png"
--- 	UiTranslate(200, 200)
--- 	UiPush()
--- 		UiMakeInteractive()
--- 		UiPush()
--- 			UiAlign("top right")
--- 			UiTranslate(40, 3.4)
--- 			UiColor(0.5291666388511658, 0.5291666388511658, 0.5291666388511658, 1)
--- 			UiFont("regular.ttf", 27)
--- 			UiText("slider")
--- 		UiPop()
--- 		UiTranslate(45.0, 3.0)
--- 		UiPush()
--- 			UiTranslate(0, 4.0)
--- 			UiImageBox("common/rect_c#ffffff_o0.10_cr3.png", 301.0, 12.0, 4, 4)
--- 		UiPop()
--- 		UiTranslate(2, 0)
--- 		UiSliderHoverColorFilter(1.0, 0.2, 0.2)
--- 		UiSliderThumbSize(8, 20)
--- 		slider = UiSlider(thumbPath, "x", slider * 295, 0, 295) / 295
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSliderHoverColorFilter)
function UiSliderHoverColorFilter(r, g, b, a) end

--- Sets the slider thumb size
--- @param width number -- Thumb width
--- @param height number -- Thumb height
--- ### Example
--- ```lua
--- local slider = 0
--- function client.draw()
--- 	local thumbPath = "common/thumb_I218_249_2430_49029.png"
--- 	UiTranslate(200, 200)
--- 	UiPush()
--- 		UiMakeInteractive()
--- 		UiPush()
--- 			UiAlign("top right")
--- 			UiTranslate(40, 3.4)
--- 			UiColor(0.5291666388511658, 0.5291666388511658, 0.5291666388511658, 1)
--- 			UiFont("regular.ttf", 27)
--- 			UiText("slider")
--- 		UiPop()
--- 		UiTranslate(45.0, 3.0)
--- 		UiPush()
--- 			UiTranslate(0, 4.0)
--- 			UiImageBox("common/rect_c#ffffff_o0.10_cr3.png", 301.0, 12.0, 4, 4)
--- 		UiPop()
--- 		UiTranslate(2, 0)
--- 		UiSliderHoverColorFilter(1.0, 0.2, 0.2)
--- 		UiSliderThumbSize(8, 20)
--- 		slider = UiSlider(thumbPath, "x", slider * 295, 0, 295) / 295
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSliderThumbSize)
function UiSliderThumbSize(width, height) end

--- @return number handle -- Handle to the screen running this script or zero if none.
--- ### Example
--- ```lua
--- --Turn off screen running current script
--- screen = UiGetScreen()
--- SetScreenEnabled(screen, false)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetScreen)
function UiGetScreen() end

--- Declares a navigation component which participates in navigation using dpad buttons of a gamepad.
--- It's an abstract entity which can be focused. It has it's own size and position on screen according to
--- UI cursor and passed arguments, but it won't be drawn on the screen.
--- Note that all navigation components which are located outside of UiWindow borders won't participate
--- in the navigation and will be considered as inactive
--- @param w number -- Width of the component
--- @param h number -- Height of the component
--- @return string id -- Generated ID of the component which can be used to get an info about the component state
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	local id = UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	if isInFocus then
--- 		local rect = UiFocusedComponentRect()
--- 		DebugPrint("Position: (" .. tostring(rect.x) .. ", " .. tostring(rect.y) .. "), Size: (" .. tostring(rect.w) .. ", " .. tostring(rect.h) .. ")")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiNavComponent)
function UiNavComponent(w, h) end

--- Sets a flag to ingore the navgation in a current UI scope or not. By default, if argument isn't
--- specified, the function sets the flag to true. If ignore is set to true, all components after the function call
--- won't participate in navigation as if they didn't exist on a scene. Flag resets back to false
--- after leaving the UI scope in which the function was called.
--- @param ignore? boolean -- Whether ignore the navigation in a current UI scope or not.
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	UiNavComponent(100, 20)
--- 	UiTranslate(150, 40)
--- 	UiPush()
--- 		UiIgnoreNavigation(true)
--- 		local id = UiNavComponent(100, 20)
--- 		local isInFocus = UiIsComponentInFocus(id)
--- 		-- will be always "false"
--- 		DebugPrint(isInFocus)
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIgnoreNavigation)
function UiIgnoreNavigation(ignore) end

--- Resets navigation state as if none componets before the function call were declared
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	local id = UiNavComponent(100, 20)
--- 	UiResetNavigation()
--- 	UiTranslate(150, 40)
--- 	UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	-- will be always "false"
--- 	DebugPrint(isInFocus)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiResetNavigation)
function UiResetNavigation() end

--- Skip update of the whole navigation state in a current draw. Could be used to override
--- behaviour of navigation in some cases. See an example.
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id = UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	if isInFocus and InputPressed("menu_up") then
--- 		-- don't let navigation to update and if component in focus
--- 		-- and do different action
--- 		UiNavSkipUpdate()
--- 		DebugPrint("Navigation action UP is overrided")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiNavSkipUpdate)
function UiNavSkipUpdate() end

--- Returns the flag whether the component with specified id is in focus or not
--- @param id string -- Navigation id of the component
--- @return boolean focus -- Flag whether the component in focus on not
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	local gId = UiNavGroupBegin()
--- 	UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id = UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	UiNavGroupEnd()
--- 	local groupInFocus = UiIsComponentInFocus(gId)
--- 	if isInFocus then
--- 		DebugPrint(groupInFocus)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiIsComponentInFocus)
function UiIsComponentInFocus(id) end

--- Begins a scope of a new navigation group. Navigation group is an entity which aggregates
--- all navigation components which was declared in it's scope. The group becomes a parent entity
--- for all aggregated components including inner group declarations. During the navigation update process
--- the game engine first checks the focused componet for proximity to components in the same group,
--- and then if none neighbour was found the engine starts to search for the closest group and the
--- closest component inside that group.
--- Navigation group has the same properties as navigation component, that is id, width and height.
--- Group size depends on its children common bounding box or it can be set explicitly.
--- Group is considered in focus if any of its child is in focus.
--- @param id? string -- Name of navigation group. If not presented, will be generated automatically.
--- @return string id -- Generated ID of the group which can be used to get an info about the group state
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	local gId = UiNavGroupBegin()
--- 	UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id = UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	UiNavGroupEnd()
--- 	local groupInFocus = UiIsComponentInFocus(gId)
--- 	if isInFocus then
--- 		DebugPrint(groupInFocus)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiNavGroupBegin)
function UiNavGroupBegin(id) end

--- Ends a scope of a new navigation group. All components before that call become
--- children of that navigation group.
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	local gId = UiNavGroupBegin()
--- 	UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id = UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	UiNavGroupEnd()
--- 	local groupInFocus = UiIsComponentInFocus(gId)
--- 	if isInFocus then
--- 		DebugPrint(groupInFocus)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiNavGroupEnd)
function UiNavGroupEnd() end

--- Set a size of current navigation group explicitly. Can be used in cases when it's needed
--- to limit area occupied by the group or make it bigger than total occupied area by children
--- in order to catch focus from near neighbours.
--- @param w number -- Width of the component
--- @param h number -- Height of the component
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiTranslate(960, 540)
--- 	local gId = UiNavGroupBegin()
--- 	UiNavGroupSize(500, 300)
--- 	UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id = UiNavComponent(100, 20)
--- 	local isInFocus = UiIsComponentInFocus(id)
--- 	UiNavGroupEnd()
--- 	local groupInFocus = UiIsComponentInFocus(gId)
--- 	if groupInFocus then
--- 		-- get a rect of the focused component parent
--- 		local rect = UiFocusedComponentRect(1)
--- 		DebugPrint("Position: (" .. tostring(rect.x) .. ", " .. tostring(rect.y) .. "), Size: (" .. tostring(rect.w) .. ", " .. tostring(rect.h) .. ")")
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiNavGroupSize)
function UiNavGroupSize(w, h) end

--- Force focus to the component with specified id.
--- @param id string -- Id of the component
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiPush()
--- 	UiTranslate(960, 540)
--- 	local id1 = UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id2 = UiNavComponent(100, 20)
--- 	UiPop()
--- 	local f1 = UiIsComponentInFocus(id1)
--- 	local f2 = UiIsComponentInFocus(id2)
--- 	local rect = UiFocusedComponentRect()
--- 	UiPush()
--- 		UiColor(1, 0, 0)
--- 		UiTranslate(rect.x, rect.y)
--- 		UiRect(rect.w, rect.h)
--- 	UiPop()
--- 	if InputPressed("menu_accept") then
--- 		UiForceFocus(id2)
--- 	end
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiForceFocus)
function UiForceFocus(id) end

--- Returns an id of the currently focused component
--- @return string id -- Id of the focused component
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiPush()
--- 	UiTranslate(960, 540)
--- 	local id1 = UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id2 = UiNavComponent(100, 20)
--- 	UiPop()
--- 	local f1 = UiIsComponentInFocus(id1)
--- 	local f2 = UiIsComponentInFocus(id2)
--- 	local rect = UiFocusedComponentRect()
--- 	UiPush()
--- 		UiColor(1, 0, 0)
--- 		UiTranslate(rect.x, rect.y)
--- 		UiRect(rect.w, rect.h)
--- 	UiPop()
--- 	DebugPrint(UiFocusedComponentId())
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFocusedComponentId)
function UiFocusedComponentId() end

--- Returns a bounding rect of the currently focused component. If the arg "n" is specified
--- the function return a rect of the n-th parent group of the component.
--- The rect contains the following fields:
--- w - width of the component
--- h - height of the component
--- x - x position of the component on the canvas
--- y - y position of the component on the canvas
--- @param n? number -- Take n-th parent of the focused component insetad of the component itself
--- @return table rect -- Rect object with info about the component bounding rectangle
--- ### Example
--- ```lua
--- function client.draw()
--- 	-- window declaration is necessary for navigation to work
--- 	UiWindow(1920, 1080)
--- 	if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 		-- active mouse cursor has higher priority over the gamepad control
--- 		-- so it will reset focused components if the mouse moves
--- 		UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 	end
--- 	UiPush()
--- 	UiTranslate(960, 540)
--- 	local id1 = UiNavComponent(100, 20)
--- 	UiTranslate(0, 50)
--- 	local id2 = UiNavComponent(100, 20)
--- 	UiPop()
--- 	local f1 = UiIsComponentInFocus(id1)
--- 	local f2 = UiIsComponentInFocus(id2)
--- 	local rect = UiFocusedComponentRect()
--- 	UiPush()
--- 		UiColor(1, 0, 0)
--- 		UiTranslate(rect.x, rect.y)
--- 		UiRect(rect.w, rect.h)
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFocusedComponentRect)
function UiFocusedComponentRect(n) end

--- Returns the last ui item size
--- @return number x -- Width
--- @return number y -- Height
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiTranslate(200, 200)
--- 	UiPush()
--- 		UiBeginFrame()
--- 			UiFont("regular.ttf", 30)
--- 			UiText("Text")
--- 		UiEndFrame()
--- 		w, h = UiGetItemSize()
--- 		DebugPrint(w .. " " .. h)
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetItemSize)
function UiGetItemSize() end

--- Enables/disables auto autotranslate function when measuring the item size
--- @param value boolean -- 
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiBeginFrame()
--- 			if InputDown("interact") then
--- 				UiAutoTranslate(false)
--- 			else
--- 				UiAutoTranslate(true)
--- 			end
--- 			UiRect(50, 50)
--- 			local w, h = UiGetItemSize()
--- 			DebugPrint(math.ceil(w) .. "x" .. math.ceil(h))
--- 		UiEndFrame()
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiAutoTranslate)
function UiAutoTranslate(value) end

--- Call to start measuring the content size. After drawing part of the
--- interface, call UiEndFrame to get its size. Useful when you want the
--- size of the image box to match the size of the content.
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiBeginFrame()
--- 			UiColor(1.0, 1.0, 0.8)
--- 			UiTranslate(UiCenter(), 300)
--- 			UiFont("bold.ttf", 40)
--- 			UiText("Hello")
--- 		local panelWidth, panelHeight = UiEndFrame()
--- 		DebugPrint(math.ceil(panelWidth) .. "x" .. math.ceil(panelHeight))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiBeginFrame)
function UiBeginFrame() end

--- Resets the current frame measured values
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiTranslate(UiCenter(), 300)
--- 		UiFont("bold.ttf", 40)
--- 		UiBeginFrame()
--- 			UiTextButton("Button1")
--- 			UiTranslate(200, 0)
--- 			UiTextButton("Button2")
--- 		UiResetFrame()
--- 		local panelWidth, panelHeight = UiEndFrame()
--- 		DebugPrint("w: " .. panelWidth .. "; h:" .. panelHeight)
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiResetFrame)
function UiResetFrame() end

--- Occupies some space for current frame (between UiBeginFrame and UiEndFrame)
--- @param width number -- Width
--- @param height number -- Height
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiBeginFrame()
--- 			UiColor(1.0, 1.0, 0.8)
--- 			UiRect(200, 200)
--- 			UiRect(300, 200)
--- 			UiFrameOccupy(500, 500)
--- 		local panelWidth, panelHeight = UiEndFrame()
--- 		DebugPrint(math.ceil(panelWidth) .. "x" .. math.ceil(panelHeight))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFrameOccupy)
function UiFrameOccupy(width, height) end

--- @return number width -- Width of content drawn between since UiBeginFrame was called
--- @return number height -- Height of content drawn between since UiBeginFrame was called
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiBeginFrame()
--- 			UiColor(1.0, 1.0, 0.8)
--- 			UiRect(200, 200)
--- 			UiRect(300, 200)
--- 		local panelWidth, panelHeight = UiEndFrame()
--- 		DebugPrint(math.ceil(panelWidth) .. "x" .. math.ceil(panelHeight))
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiEndFrame)
function UiEndFrame() end

--- Sets whether to skip items in current ui scope for current ui frame. This items won't affect on the frame size
--- @param skip boolean -- Should skip item
--- ### Example
--- ```lua
--- function client.draw()
--- 	UiPush()
--- 		UiBeginFrame()
--- 			UiFrameSkipItem(true)
--- 			--[[
--- 				...
--- 			]]
--- 		UiEndFrame()
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiFrameSkipItem)
function UiFrameSkipItem(skip) end

--- @return number frameNo -- Frame number since the level start
--- ### Example
--- ```lua
--- function client.draw()
--- 	local fNo = GetFrame()
--- 	DebugPrint(fNo)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetFrameNo)
function UiGetFrameNo() end

--- @return number index -- Language index
--- ### Example
--- ```lua
--- local n = UiGetLanguage()
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiGetLanguage)
function UiGetLanguage() end

--- @param state number -- 
--- ### Example
--- ```lua
--- #include "ui/ui_helpers.lua"
--- function client.draw()
--- 	UiPush()
--- 		-- If the last input device was a gamepad, hide the cursor and proceed to control through D-pad navigation
--- 		if LastInputDevice() == UI_DEVICE_GAMEPAD then
--- 			UiSetCursorState(UI_CURSOR_HIDE_AND_LOCK)
--- 		end
--- 		UiMakeInteractive()
--- 		UiAlign("center")
--- 		UiColor(1.0, 1.0, 1.0)
--- 		UiButtonHoverColor(1.0, 0.5, 0.5)
--- 		UiFont("regular.ttf", 50)
--- 		UiTranslate(UiCenter(), 200)
--- 		UiTranslate(0, 100)
--- 		if UiTextButton("1") then
--- 			DebugPrint(1)
--- 		end
--- 		UiTranslate(0, 100)
--- 		if UiTextButton("2") then
--- 			DebugPrint(2)
--- 		end
--- 	UiPop()
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#UiSetCursorState)
function UiSetCursorState(state) end

