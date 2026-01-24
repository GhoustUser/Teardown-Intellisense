--- @meta


--- @return fun(): number? -- Iterator for players in current session
function Players()
    local players = GetAllPlayers()
    local idx = 0

    return function()
        idx = idx + 1
        if idx <= #players then
            return players[idx]
        end
        return nil
    end
end

--- @return fun(): number? -- Iterator for players added since last tick
function PlayersAdded()
    local players = GetAddedPlayers()
    local idx = 0

    return function()
        idx = idx + 1
        if idx <= #players then
            return players[idx]
        end
        return nil
    end
end

--- @return fun(): number? -- Iterator for players removed since last tick
function PlayersRemoved()
    local players = GetRemovedPlayers()
    local idx = 0

    return function()
        idx = idx + 1
        if idx <= #players then
            return players[idx]
        end
        return nil
    end
end
