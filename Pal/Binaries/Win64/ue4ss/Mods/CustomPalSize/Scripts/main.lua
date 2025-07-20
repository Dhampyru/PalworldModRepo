-- Author: yakuzadeso

local config = require("./config")

local hooked = false

local scaleFactors = {
    [5] = { X = config.scaleXL, Y = config.scaleXL, Z = config.scaleXL },
    [4] = { X = config.scaleL, Y = config.scaleL, Z = config.scaleL },
    [3] = { X = config.scaleM, Y = config.scaleM, Z = config.scaleM },
    [2] = { X = config.scaleS, Y = config.scaleS, Z = config.scaleS },
    [1] = { X = config.scaleXS, Y = config.scaleXS, Z = config.scaleXS },
}

local rareScaleFactor = { X = config.scaleRarePal, Y = config.scaleRarePal, Z = config.scaleRarePal }

local affectSizes = {
    [5] = config.affectsXL,
    [4] = config.affectsL,
    [3] = config.affectsM,
    [2] = config.affectsS,
    [1] = config.affectsXS
}

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    if not hooked then
        NotifyOnNewObject("/Script/Pal.PalCharacter", function(character)
            if character.StaticCharacterParameterComponent.IsPal == true then
                local size = character.StaticCharacterParameterComponent.Size
                local isRarePal = character.StaticCharacterParameterComponent:IsRarePal()

                if affectSizes[size] and (not config.affectsRarePalsOnly or (config.affectsRarePalsOnly and isRarePal)) then
                    local scaleFactor = isRarePal and rareScaleFactor or scaleFactors[size]
                    character:SetActorScale3D(scaleFactor)
                end
            end
        end)
    end
    hooked = true
end)

RegisterHook("/Script/Pal.PalCharacter:IsInitialized", function(Context)
    character = Context:get()
    ExecuteAsync(function()
        if character.StaticCharacterParameterComponent.IsPal == true then
            local size = character.StaticCharacterParameterComponent.Size
            local isRarePal = character.StaticCharacterParameterComponent:IsRarePal()

            if affectSizes[size] and (not config.affectsRarePalsOnly or (config.affectsRarePalsOnly and isRarePal)) then
                local scaleFactor = isRarePal and rareScaleFactor or scaleFactors[size]
                character:SetActorScale3D(scaleFactor)
            end
        end
    end)
end)
