--- @meta


--- Clamps a value between a minimum and maximum value.
--- ### Example
--- ```lua
--- local clampedValue = clamp(15, 0, 10) -- 10
--- ```
--- ### Example
--- ```lua
--- local trimmed = trim("   Hello World   ") -- "Hello World"
--- ```
--- @param value number -- Value to clamp
--- @param mi number -- Minimum value
--- @param ma number -- Maximum value
--- @return number -- Clamped value
function clamp(value, mi, ma) end

--- Trims whitespace from both ends of a string.
--- @param s string -- String to trim
--- ### Example
--- ```lua
--- DebugPrint(startsWith("Hello World", "Hello")) -- true
--- ```
--- @return string -- Trimmed string
function trim(s) end

--- Checks if a string starts with a given substring.
--- @param str string -- String to check
--- ### Example
--- ```lua
--- local words = splitString("The quick brown fox", " ")
--- -- words = {"The", "quick", "brown", "fox"}
--- ```
--- @param start string -- Substring to check for
--- @return boolean -- True if the string starts with the substring, false otherwise
function startsWith(str, start) end

--- Splits a string into a table of substrings based on a delimiter.
--- @param str string -- String to split
--- ### Example
--- ```lua
--- DebugPrint(hasWord("The quick brown fox", "Quick")) -- true
--- ```
--- @param delimiter string -- Delimiter to split by
--- @return table -- Table of substrings
function splitString(str, delimiter) end

--- Checks if a word exists in a string (case-insensitive).
--- @param str string -- String to search
--- ### Example
--- ```lua
--- progressBar(200, 20, 0.75) -- Renders a progress bar at 75%
--- ```
--- @param word string -- Word to search for
--- @return boolean -- True if the word exists in the string, false otherwise
function hasWord(str, word) end

--- Smoothstep interpolation function.
--- @param edge0 number -- Lower edge
--- ### Example
--- ```lua
--- local randomValue = rnd(1, 10) -- Random number between 1 and 10
--- ```
--- @param edge1 number -- Upper edge
--- @param x number -- Value to interpolate
--- @return number -- Interpolated value
function smoothstep(edge0, edge1, x) end

--- Renders a progress bar UI element.
--- @param w number -- Width of the progress bar
--- @param h number -- Height of the progress bar
--- @param t number -- Progress value (0.0 to 1.0)
--- @return nil
function progressBar(w, h, t) end

--- Generates a random floating-point number within a range.
--- @param mi number -- Minimum value
--- ### Example
--- ```lua
--- local randomVector = rndVec(5) -- Random vector with magnitude 5
--- ```
--- @param ma number -- Maximum value
--- @return number -- Random number between min and max
function rnd(mi, ma) end

--- Generates a random 3D vector with a specified magnitude.
--- @param s number -- Magnitude of the vector
--- @return TVec -- Random 3D vector
function rndVec(s) end

--- @param startloc TVec -- Starting location of the raycast
--- @param direction TVec -- Direction of the raycast
--- @param distance number -- Maximum distance of the raycast
--- @return boolean hit -- Whether the raycast hit something
--- @return number dist -- Distance to the hit point
--- @return TVec normal -- Normal of the hit surface
--- @return number shape -- Shape ID of the hit object
--- @return TVec hitlocation -- Location of the hit point
--- ### Example
--- ```lua
--- local hit, dist, normal, shape, hitlocation = queryRaycastLocation(startloc, direction, distance)
--- if hit then
---   DebugPrint("Hit location " .. VecStr(hitlocation) .. " at distance: " .. dist)
--- end
function queryRaycastLocation(startloc, direction, distance) end
