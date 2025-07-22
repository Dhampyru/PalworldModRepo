---@class UPalUtility
local Utility = StaticFindObject("/Script/Pal.Default__PalUtility")

---@type table<string, { item: string, min: integer, max: integer }>
local Configuration = require("config").PalKillRewards

---@type string
local ScriptDirectory = debug.getinfo(1, "S").source:match("@?(.*[\\/])") or "./"

---@param Message string
local function WriteLog(Message)
    local Path = ScriptDirectory .. "PalKillRewardLog.txt"
    local File = io.open(Path, "a")
    if File then
        File:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. Message .. "\n")
        File:close()
    end
end

---@param Entity APalCharacter
---@return string|nil
local function GetPalCharacterID(Entity)
    local Param = Entity.CharacterParameterComponent
    local Success, CharacterID = pcall(function()
        return Param:GetIndividualParameter():GetCharacterID():ToString()
    end)
    return Success and CharacterID or nil
end

---@param Victim APalCharacter
---@param Attacker AActor
local function HandlePalKillReward(Victim, Attacker)
    if not Victim or not Attacker then return end

    local PalID = GetPalCharacterID(Victim)
    if not PalID then return end

    local Reward = Configuration[PalID]
    if not Reward then return end

    local PlayerState = Attacker.PlayerState
    if not PlayerState and Utility:IsOtomo(Attacker) then
        local Trainer = Utility:GetTrainerPlayerController_ForServer(Attacker)
        PlayerState = Trainer and Trainer.PlayerState
    end

    if not PlayerState then return end

    local Inventory = PlayerState:GetInventoryData()
    if not Inventory then return end

    local Amount = math.random(Reward.min or 1, Reward.max or Reward.min or 1)
    Inventory:AddItem_ServerInternal(FName(tostring(Reward.item), 0), Amount, false, 0)

    local PlayerName = PlayerState.PlayerNamePrivate:ToString() or "Unknown"
    WriteLog(string.format("Player '%s' killed '%s' and received %d x %s", PlayerName, PalID, Amount, Reward.item))
end

io.write("\27[32mMOD ( Pal Kill Rewards ) By CCPlays\27[0m\n")

---@param Context UObject
---@param EventData FPalDeadInfo
RegisterHook("/Script/Pal.PalCharacter:OnDeadCharacter", function(Context, EventData)
    local Data = EventData:get()
    HandlePalKillReward(Data.SelfActor, Data.LastAttacker)
end)
