--- @meta


--- Returns an iterator for players in current session
--- ### Example
--- ```lua
--- for p in Players() do
---	-- run code for each player
--- end
--- ```
--- @return fun(): number? -- Iterator
function Players() end

--- Returns an iterator for players added since last tick
--- ### Example
--- ```lua
--- for p in PlayersAdded() do
---	-- run code for each added player
--- 	DebugPrint(GetPlayerName(p) .. " joined the game")
--- end
--- ```
--- @return fun(): number? -- Iterator
function PlayersAdded() end

--- Returns an iterator for players removed since last tick
--- ### Example
--- ```lua
--- for p in PlayersRemoved() do
---	-- run code for each removed player
--- 	DebugPrint(GetPlayerName(p) .. " left the game")
--- end
--- ```
--- @return fun(): number? -- Iterator
function PlayersRemoved() end
