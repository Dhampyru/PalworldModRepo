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
				item.InvadeProbability  = palConfig.InvadeProbability	
				item.InvadeOccurablePlayerLevel  = palConfig.InvadeOccurablePlayerLevel				
				item.InvadeStartPoint_BaseCampRadius_Min_cm  = palConfig.InvadeStartPoint_BaseCampRadius_Min_cm
				item.InvadeStartPoint_BaseCampRadius_Max_cm  = palConfig.InvadeStartPoint_BaseCampRadius_Max_cm
				--item.InvadeCollTime_Min_Minutes  = palConfig.InvadeCollTime_Min_Minutes
				--item.InvadeCollTime_Max_Minutes  = palConfig.InvadeCollTime_Max_Minutes
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raid probability set to " .. palConfig.InvadeProbability .. palConfig.palRedColorWrapperBack)	
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raids start from thos player's level set to " .. palConfig.InvadeOccurablePlayerLevel .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raid party spawn this far from the base min set to " .. palConfig.InvadeStartPoint_BaseCampRadius_Min_cm .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raid party spawn this far from the base max set to " .. palConfig.InvadeStartPoint_BaseCampRadius_Max_cm .. palConfig.palRedColorWrapperBack)
		--print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Minimum delay between raids set to " .. palConfig.InvadeCollTime_Min_Minutes .. palConfig.palRedColorWrapperBack)
		--print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Maximum delay between raids set to " .. palConfig.InvadeCollTime_Max_Minutes .. palConfig.palRedColorWrapperBack)		
    end
    palConfig.palCheckRestart = 1
end)


-- [DEDICATED SRV] Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function(Context)
    if not palConfig.serverAcknowledgedPossession then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.InvadeProbability  = palConfig.InvadeProbability	
				item.InvadeOccurablePlayerLevel  = palConfig.InvadeOccurablePlayerLevel				
				item.InvadeStartPoint_BaseCampRadius_Min_cm  = palConfig.InvadeStartPoint_BaseCampRadius_Min_cm
				item.InvadeStartPoint_BaseCampRadius_Max_cm  = palConfig.InvadeStartPoint_BaseCampRadius_Max_cm
				--item.InvadeCollTime_Min_Minutes  = palConfig.InvadeCollTime_Min_Minutes
				--item.InvadeCollTime_Max_Minutes  = palConfig.InvadeCollTime_Max_Minutes
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raid probability set to " .. palConfig.InvadeProbability .. palConfig.palRedColorWrapperBack)	
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raids start from thos player's level set to " .. palConfig.InvadeOccurablePlayerLevel .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raid party spawn this far from the base min set to " .. palConfig.InvadeStartPoint_BaseCampRadius_Min_cm .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Raid party spawn this far from the base max set to " .. palConfig.InvadeStartPoint_BaseCampRadius_Max_cm .. palConfig.palRedColorWrapperBack)
		--print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Minimum delay between raids set to " .. palConfig.InvadeCollTime_Min_Minutes .. palConfig.palRedColorWrapperBack)
		--print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Maximum delay between raids set to " .. palConfig.InvadeCollTime_Max_Minutes .. palConfig.palRedColorWrapperBack)	
    end
    palConfig.serverAcknowledgedPossession = true
end)