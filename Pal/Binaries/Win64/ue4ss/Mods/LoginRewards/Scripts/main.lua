local json = require("libs/json")


---@type string
local scriptDir = debug.getinfo(1, "S").source:match([[^@?(.*[\/])[^\/]-$]])
local config = dofile(scriptDir .. "config.lua")

local playersFile = scriptDir .. "Players.json"

---@type table<string, { lastRewardUnix: integer, streak: integer }>
local players = {}



---@return nil
local function loadPlayers()
    local file = io.open(playersFile, "r")
    if file then
        players = json.decode(file:read("*a")) or {}
        file:close()
        return
    end
    local f = io.open(playersFile, "w")
    if f then
        f:write("{}")
        f:close()
    end
end



---@return nil
local function savePlayers()
    local file = io.open(playersFile, "w")
    if file then
        file:write(json.encode(players))
        file:close()
    end
end



--@param playerState userdata
--@return string
local function getPlayerName(playerState)
    if playerState and playerState:IsValid() and playerState.PlayerNamePrivate then
        return playerState.PlayerNamePrivate:ToString()
    end
    return "Unknown"
end



--@param playerName string
--@return userdata | nil
local function findPlayerByName(playerName)
    for _, player in ipairs(FindAllOf("PalPlayerCharacter")) do
        local state = player.PlayerState
        if state and state:IsValid() and getPlayerName(state) == playerName then
            return state
        end
    end
    return nil
end



---@param playerName string
---@return nil
local function giveLoginStreakReward(playerName)
    local now = os.time() -- current unix time (UTC-safe)
    local data = players[playerName] or {
        lastRewardUnix = 0,
        streak = 0
    }

    local timeSince = now - data.lastRewardUnix

    if timeSince < 86400 then
        return
    end

    if timeSince < 172800 then
        data.streak = data.streak + 1 
    else
        data.streak = 1 
    end

    if data.streak > #config.StreakRewards then
        data.streak = 1
    end

    local rewards = config.StreakRewards[data.streak]
    local playerState = findPlayerByName(playerName)

    if playerState and playerState:IsValid() then
        local inventory = playerState:GetInventoryData()
        if inventory and inventory:IsValid() then
            for item, quantity in pairs(rewards) do
                inventory:AddItem_ServerInternal(FName(item), quantity, false, 0)
            end
            data.lastRewardUnix = now 
            players[playerName] = data
            savePlayers()
        end
    end
end



io.write("\27[32mMOD ( LoginRewards ) By Snorkles / SharkeyXO\27[0m\n")



---@param Context UObject
---@param Character APalPlayerCharacter
RegisterHook("/Script/Pal.PalPlayerCharacter:OnCompleteInitializeParameter", function(Context, Character)
    local Player = Context:get()
    if Player and Player.PlayerState then
        giveLoginStreakReward(getPlayerName(Player.PlayerState))
    end
end)

loadPlayers()
