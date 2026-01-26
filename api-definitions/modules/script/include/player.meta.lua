--- @meta


--- ### Example
--- ```lua
--- for p in Players() do
---    -- run code for each player
--- end
--- ```
--- @return fun(): number? -- Iterator for players in current session
function Players() end

--- ### Example
--- ```lua
--- for p in PlayersAdded() do
---     DebugPrint(GetPlayerName(p) .. " joined the game")
--- end
--- ```
--- @return fun(): number? -- Iterator for players added since last tick
function PlayersAdded() end

--- ### Example
--- ```lua
--- for p in PlayersRemoved() do
---     DebugPrint(GetPlayerName(p) .. " left the game")
--- end
--- ```
--- @return fun(): number? -- Iterator for players removed since last tick
function PlayersRemoved() end
