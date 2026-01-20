--- @meta


--- @param type string -- Event type
--- @return number value -- Number of event available
--- ### Example
--- ```lua
--- local count = GetEventCount("matchended")
--- for i=1, count do
--- 	local name1, name2, score1, score2 = GetEvent("matchended", i)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEventCount)
function GetEventCount(type) end

--- Post a custom event with the specified name and parameters.
--- The parameters will be saved in a memory stream and can be retrieved later using GetEvent.
--- @param eventName string -- Event name
--- @param ...? any -- Optional parameters to send with the event.
--- ### Example
--- ```lua
--- PostEvent("matchended", "team1", "team2", 5, 10)
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#PostEvent)
function PostEvent(eventName, ...) end

--- @param type string -- Event type
--- @param index number -- Event index (starting with one)
--- @return varying returnValues -- Return values depending on event type
--- ### Example
--- ```lua
--- local count = GetEventCount("matchended")
--- for i=1, count do
--- 	local name1, name2, score1, score2 = GetEvent("matchended", i)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEvent)
function GetEvent(type, index) end

