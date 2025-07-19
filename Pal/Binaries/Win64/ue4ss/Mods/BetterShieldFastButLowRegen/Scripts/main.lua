-- made by caites

local palConfig = require "config"

-- Prints the mod successful loading message in red
print(palConfig.palRedColorWrapperFront .. palConfig.palModName .. " version " .. palConfig.palModVersion .. " loaded for game version " .. palConfig.palGameVersion .. palConfig.palRedColorWrapperBack)

-- Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    if palConfig.palCheckRestart ~= 1 then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.PlayerShield_RecoverStartTime  = palConfig.PlayerShield_RecoverStartTime	
				item.PlayerShield_RecoverPercentPerSecond  = palConfig.PlayerShield_RecoverPercentPerSecond				
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Delay before shield recovery set to " .. palConfig.PlayerShield_RecoverStartTime .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Speed of shield recovery set to " .. palConfig.PlayerShield_RecoverPercentPerSecond .. palConfig.palRedColorWrapperBack)
				
    end
    palConfig.palCheckRestart = 1
end)
