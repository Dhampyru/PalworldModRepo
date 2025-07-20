-- ==========================================================================
-- Stop Drop and Roll

-- Description:
-- Makes it so rolling while on fire reduces the amount of time it takes for the fire status to disappear
-- In other words: STOP DROP AND ROLL!

-- Authors:
-- CTNeptune

-- Credits:
-- Modders in the Palworld Modding Discord
-- ==========================================================================

local config = require("config")

local _BurnEffect = nil

ExecuteInGameThread(function()
    LoadAsset("/Game/Pal/Blueprint/Status/BP_Status_Burn.BP_Status_Burn_C")

    RegisterHook("/Game/Pal/Blueprint/Status/BP_Status_Burn.BP_Status_Burn_C:OnBeginStatus", 
    function (Context)
        if Context:get() ~= nil and Context:get():IsValid() then
            if Context:get():IsValid() and Context:get():GetOwner():IsPlayerControlled() then
                _BurnEffect = Context:get()
            end
        end
    end)

    LoadAsset("/Game/Pal/Blueprint/Action/Common/BP_Action_Rolling.BP_Action_Rolling_C")

    RegisterHook("/Game/Pal/Blueprint/Action/Common/BP_Action_Rolling.BP_Action_Rolling_C:OnBeginAction", 
    function (Context)
        if _BurnEffect ~= nil and _BurnEffect:IsValid() then
            _BurnEffect.DurationTimer_BP = _BurnEffect.DurationTimer_BP - config._RollTimerReduction
        end
    end)

    LoadAsset("/Game/Pal/Blueprint/Status/BP_Status_Burn.BP_Status_Burn_C")

    RegisterHook("/Game/Pal/Blueprint/Status/BP_Status_Burn.BP_Status_Burn_C:OnEndStatus", 
    function (Context)
        _BurnEffect = nil
    end)
  end)