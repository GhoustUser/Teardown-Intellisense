--- @meta


--- The event system allows scripts to register listeners for events and trigger them. Events are used to communicate between scripts. 
--- Events can also be triggered by the game engine, such as player death, explosion, etc. 

--- The following built-in events are available. 
--- You can also create custom events that can be triggered by your scripts and listened to by other scripts. 
--- @alias EventType
--- | "playerhurt" Triggered when a player is hurt. | Parameters: playerId (number), healthBefore (number), healthAfter (number), attackerId (number), point (TVec), impulse (TVec). | Server and Client.
--- | "playerdied" Triggered when a player dies. | Parameters: playerId (number), attackerId (number), damage (number), healthBefore (number), cause (string), point (TVec), impulse (TVec). | Server and Client.
--- | "explosion" Triggered when an explosion occurs. | Parameters: point (TVec), strength (number). | Server only.
--- | "projectilehit" Triggered when a projectile hits an object. | Parameters: shape (number), point (TVec), direction (TVec). | Server only.


--- @param type EventType -- Event type
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
--- @return any returnValues -- Return values depending on event type
--- ### Example
--- ```lua
--- local count = GetEventCount("matchended")
--- for i=1, count do
--- 	local name1, name2, score1, score2 = GetEvent("matchended", i)
--- end
--- ```
--- [View Documentation](https://teardowngame.com/experimental/api.html#GetEvent)
function GetEvent(type, index) end

