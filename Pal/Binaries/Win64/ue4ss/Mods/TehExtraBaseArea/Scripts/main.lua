local config = require "config"
local defaultRange = 3500
local defaultScale = {X = 70.01, Y = 70.01, Z = 100.01}

-- modifyPalBox code courtesy of slinky.dev on Discord!
local function modifyPalBox()
    local areaRange = StaticFindObject("/Game/Pal/Blueprint/MapObject/BuildObject/BP_BuildObject_PalBoxV2.BP_BuildObject_PalBoxV2_C:AreaRange_GEN_VARIABLE")
    local areaRange1 = StaticFindObject("/Game/Pal/Blueprint/MapObject/BuildObject/BP_BuildObject_PalBoxV2.BP_BuildObject_PalBoxV2_C:AreaRange1_GEN_VARIABLE")
    if not areaRange:IsValid() and not areaRange1:IsValid() then
        print("[TEBA] Circle Extender: Could Not Get Area Ranges\n")
        return
    end
    local scaledRange = config.AreaRange / defaultRange
    local scaled3D = { X = defaultScale.X * scaledRange, Y = defaultScale.Y * scaledRange, Z = defaultScale.Z * scaledRange}
    areaRange.RelativeScale3D = scaled3D
    areaRange1.RelativeScale3D = scaled3D
    print("[TEBA] Moved blue line...")
end

local function editBaseArea(base_model)
    if base_model and base_model:IsValid() then
        print("[TEBA] Found Base: " .. base_model:GetFullName())
        print("[TEBA] Waiting 15 seconds to allow the model to finish initialization")
        ExecuteWithDelay(15000, function()
            print("[TEBA] Default AreaRange: " .. base_model.AreaRange)
            base_model.AreaRange = config.AreaRange
            print("[TEBA] New base Area: " .. base_model.AreaRange)
        end)
    end
end

local function editGameSettings(PalGameSetting)
    print("[TEBA] Found PalGameSetting: " .. PalGameSetting:GetFullName() .. " | Editing Game Settings")
    PalGameSetting.SpawnerDisableDistanceCM_FromBaseCamp = config.SpawnerDisableDistanceCM_FromBaseCamp
    PalGameSetting.BaseCampExtraWorkAreaRange = config.AreaRange
    PalGameSetting.BaseCampNeighborMinimumDistance = config.BaseCampNeighborMinimumDistance
    PalGameSetting.BaseCampAreaRange = config.AreaRange
    PalGameSetting.BaseCampPalCombatRange_AddCampRange = config.BaseCampPalCombatRange_AddCampRange
end

NotifyOnNewObject("/Script/Pal.PalBaseCampModel", editBaseArea)
NotifyOnNewObject("/Script/Pal.PalBuildObjectBaseCampPoint", modifyPalBox)
if (config.EditGameSettings) then
    print("[TEBA] Edit Game Settings is Enabled")
    NotifyOnNewObject("/Script/Pal.PalGameSetting", editGameSettings)
end